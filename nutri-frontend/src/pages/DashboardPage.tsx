import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { useSeguimientoDieta } from "../hooks/useSeguimientoDieta";
import { ResumenSemanalCard } from "../components/ResumenSemanalCard";
import { CaloriasConsumidasCard } from "../components/CaloriasConsumidasCard";
import { EstadoGeneralCard } from "../components/EstadoGeneralCard";
import { ResumenHabitosCard } from "../components/ResumenHabitosCard";

function DashboardPage() {
  const { dietaId } = useParams<{ dietaId: string }>();
  const dietaIdNumber = Number(dietaId);
  const [mostrarFrase, setMostrarFrase] = useState(false);

  const { seguimiento } = useSeguimientoDieta(dietaIdNumber);

  const [semanaActual, setSemanaActual] = useState(0);

  const hoy = new Date();
  hoy.setHours(0, 0, 0, 0);

  const desplazamiento = hoy.getDay() === 0 ? 6 : hoy.getDay() - 1;

  const lunes = new Date(hoy);
  lunes.setDate(hoy.getDate() - desplazamiento - semanaActual * 7);

  const finSemana =
    semanaActual === 0
      ? new Date(hoy.getTime() - 86400000)
      : new Date(lunes.getTime() + 6 * 86400000);

  const comidasSemana = seguimiento.filter((s) => {
    const fecha = new Date(s.fecha.split("T")[0]);
    fecha.setHours(0, 0, 0, 0);
    return fecha >= lunes && fecha <= finSemana;
  });

  const total = comidasSemana.length;
  const completadas = comidasSemana.filter((s) => s.consumido).length;

  const [caloriasSemanales, setCaloriasSemanales] = useState<
    { dia: string; objetivo: number; consumido: number }[]
  >([]);

  const [estadoHabitos, setEstadoHabitos] = useState<{
    energia: number;
    estres: number;
    motivacion: number;
    agua: number;
    sueno: number;
    ejercicio: number;
  } | null>(null);

  useEffect(() => {
    if (!isNaN(dietaIdNumber)) {
      fetch(`http://localhost:8080/api/seguimiento-dieta/calorias-semanales/dieta/${dietaIdNumber}`)
        .then((res) => res.json())
        .then(setCaloriasSemanales)
        .catch(console.error);

      fetch(`http://localhost:8080/api/seguimiento-habitos/resumen/${dietaIdNumber}/semana/${semanaActual}`)
        .then((res) => res.json())
        .then(setEstadoHabitos)
        .catch(console.error);
    }
  }, [dietaIdNumber, semanaActual]);

  const diasMap = ["domingo", "lunes", "martes", "miércoles", "jueves", "viernes", "sábado"];
  const caloriasFiltradas = caloriasSemanales.filter((d) => {
    const index = diasMap.indexOf(d.dia.toLowerCase());
    if (index === -1) return false;
    const fecha = new Date(lunes);
    fecha.setDate(lunes.getDate() + index);
    return fecha >= lunes && fecha <= finSemana;
  });

  const frasesMotivacionales = [
    "Cada día es una nueva oportunidad para mejorar.",
    "No se trata de ser perfecto, sino constante.",
    "El esfuerzo de hoy es el éxito de mañana.",
    "Cree en ti y todo será posible.",
    "Pequeños hábitos, grandes cambios.",
    "Hazlo por ti, por tu salud y por tu bienestar.",
    "Hoy es un buen día para empezar de nuevo.",
    "Los grandes logros comienzan con pequeños pasos.",
    "Tu disciplina te llevará más lejos que tu motivación.",
    "Si puedes soñarlo, puedes lograrlo.",
    "No importa cuántas veces caes, sino cuántas te levantas.",
    "Cuida tu cuerpo, es el único lugar que tienes para vivir.",
    "Transforma tu rutina, transforma tu vida.",
    "Sé paciente. Los cambios reales llevan tiempo.",
    "Tu futuro yo te agradecerá lo que haces hoy.",
    "Comer bien es un acto de amor propio.",
    "Cada comida saludable es una victoria.",
    "La constancia es más poderosa que la intensidad.",
    "No lo pienses demasiado, solo empieza.",
    "Cada pequeño paso cuenta.",
    "El progreso es progreso, por pequeño que sea.",
    "Hazlo con amor, no con presión.",
    "Cambia excusas por acciones.",
    "El cambio empieza en tu mente.",
    "No te compares, enfócate en tu camino.",
    "Tu salud es tu mayor riqueza.",
    "Empieza donde estás. Usa lo que tienes. Haz lo que puedas.",
    "Si te caes siete veces, levántate ocho.",
    "La energía positiva comienza con una decisión positiva.",
    "Cuidarte no es egoísmo, es responsabilidad."
  ];
  const fraseSeleccionada = frasesMotivacionales[Math.floor(Math.random() * frasesMotivacionales.length)];

  return (
    <div className="p-6 space-y-6">
      {/* Cabecera con controles */}
      <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Seguimiento Semanal</h1>

        <div className="flex items-center gap-2 flex-wrap">
          <button
            className="px-4 py-2 rounded-full border border-gray-300 bg-white text-gray-700 hover:bg-emerald-50 hover:text-emerald-700 font-semibold transition-all shadow-sm"
            onClick={() => setMostrarFrase(true)}
          >
            ✨ Frase motivacional
          </button>

          <button
            className="px-4 py-2 rounded-full border border-gray-300 bg-white text-gray-700 hover:bg-emerald-50 hover:text-emerald-700 font-semibold transition-all shadow-sm"
            onClick={() => setSemanaActual((prev) => prev + 1)}
          >
            ⬅️ Semana anterior
          </button>

          <span className="text-sm font-medium text-gray-500 px-2">
            Semana {semanaActual === 0 ? "actual" : `-${semanaActual}`}
          </span>

          {semanaActual > 0 && (
            <button
              className="px-4 py-2 rounded-full border border-gray-300 bg-white text-gray-700 hover:bg-emerald-50 hover:text-emerald-700 font-semibold transition-all shadow-sm"
              onClick={() => setSemanaActual((prev) => prev - 1)}
            >
              Semana siguiente ➡️
            </button>
          )}
        </div>
      </div>

      {/* Contenido del dashboard */}
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
        <ResumenSemanalCard completadas={completadas} total={total} />
        <EstadoGeneralCard
          energia={estadoHabitos?.energia ?? 0}
          estres={estadoHabitos?.estres ?? 0}
          motivacion={estadoHabitos?.motivacion ?? 0}
        />
        <ResumenHabitosCard
          agua={estadoHabitos?.agua ?? 0}
          sueno={estadoHabitos?.sueno ?? 0}
          ejercicio={estadoHabitos?.ejercicio ?? 0}
        />
      </div>

      <CaloriasConsumidasCard datos={caloriasFiltradas} />

      {/* Modal de frase motivacional */}
      {mostrarFrase && (
        <div className="fixed inset-0 bg-black/40 z-50 flex items-center justify-center px-4">
          <div className="bg-white rounded-2xl shadow-xl p-8 max-w-md w-full relative animate-fade-in">
            <button
              onClick={() => setMostrarFrase(false)}
              className="absolute top-3 right-3 text-gray-400 hover:text-gray-600 text-xl font-bold"
              aria-label="Cerrar"
            >
              ×
            </button>
            <h2 className="text-xl font-bold text-emerald-700 mb-4 text-center">Tu frase de hoy 💬</h2>
            <p className="text-gray-700 text-center text-lg italic">{fraseSeleccionada}</p>
          </div>
        </div>
      )}
    </div>
  );
}

export default DashboardPage;
