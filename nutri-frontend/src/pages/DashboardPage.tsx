import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import Swal from "sweetalert2"; // Opcional para otros casos
import { groupBy } from "lodash";

// Toast config (reutilizable)
const Toast = Swal.mixin({
  toast: true,
  position: "bottom-end",
  showConfirmButton: false,
  timer: 2500,
  timerProgressBar: true,
  background: "#fff",
  color: "#333",
});

import { useSeguimientoDieta } from "../hooks/useSeguimientoDieta";
import { ResumenSemanalCard } from "../components/ResumenSemanalCard";
import { CaloriasConsumidasCard } from "../components/CaloriasConsumidasCard";
import { EstadoGeneralCard } from "../components/EstadoGeneralCard";
import { ResumenHabitosCard } from "../components/ResumenHabitosCard";

function DashboardPage() {
  const { dietaId } = useParams<{ dietaId: string }>();
  const dietaIdNumber = Number(dietaId);
  const [mostrarFrase, setMostrarFrase] = useState(false);
  const [fechaCreacion, setFechaCreacion] = useState<Date | null>(null);
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
      // Obtener fecha de creación
      fetch(`http://localhost:8080/api/dietas/${dietaIdNumber}`)
        .then((res) => res.json())
        .then((data) => {
          setFechaCreacion(new Date(data.created));
        })
        .catch(console.error);

      fetch(`http://localhost:8080/api/seguimiento-habitos/resumen/${dietaIdNumber}/semana/${semanaActual}`)
        .then((res) => res.json())
        .then(setEstadoHabitos)
        .catch(console.error);
    }
  }, [dietaIdNumber, semanaActual]);

 const caloriasAgrupadas = groupBy(comidasSemana, (c) => c.fecha.split("T")[0]);

const caloriasFiltradas = Object.entries(caloriasAgrupadas)
  .map(([fecha, comidasDelDia]) => {
    const consumido = comidasDelDia
      .filter((c) => c.consumido)
      .reduce((acc, c) => acc + c.comidaModelo.caloriasTotales, 0);

    const objetivo = comidasDelDia.reduce(
      (acc, c) => acc + c.comidaModelo.caloriasTotales,
      0
    );

    return {
      fecha, // es string, como se espera en el componente
      consumido,
      objetivo,
    };
  })
  .sort((a, b) => new Date(a.fecha).getTime() - new Date(b.fecha).getTime());



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

  const handleSemanaAnterior = () => {
    const lunesAnterior = new Date(lunes);
    lunesAnterior.setDate(lunesAnterior.getDate() - 7);

    const domingoAnterior = new Date(lunesAnterior);
    domingoAnterior.setDate(lunesAnterior.getDate() + 6);

    // Solo impedir si toda la semana es anterior a la creación
    if (fechaCreacion && domingoAnterior < fechaCreacion) {
      Toast.fire({
        icon: "warning",
        title: "No puedes ver semanas antes de la creación de tu dieta.",
      });
      return;
    }
    setSemanaActual((prev) => prev + 1);
  };

  return (
   <div className="p-6 bg-gray-100 min-h-screen space-y-6">
      {/* Cabecera con controles */}
      <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-6">
        <h1 className="text-3xl font-bold text-emerald-700">Seguimiento Semanal</h1>

        <div className="flex items-center gap-2 flex-wrap">
          <button
            className="px-4 py-2 rounded-full border border-gray-300 bg-white text-gray-700 hover:bg-emerald-50 hover:text-emerald-700 font-semibold transition-all shadow-sm"
            onClick={() => setMostrarFrase(true)}
          >
            ✨ Frase motivacional
          </button>

          <button
            className="px-4 py-2 rounded-full border border-gray-300 bg-white text-gray-700 hover:bg-emerald-50 hover:text-emerald-700 font-semibold transition-all shadow-sm"
            onClick={handleSemanaAnterior}
          >
            ⬅️ Semana anterior
          </button>

          <span className="text-sm font-medium text-emerald-700 px-2">
            Semana{" "}
            {semanaActual === 0
              ? "actual"
              : semanaActual === 1
              ? "anterior"
              : `x${semanaActual}`}
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

      {/* Contenido */}
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

      {/* Modal frase */}
      {mostrarFrase && (
      <div className="fixed inset-0 backdrop-blur-sm z-50 flex items-center justify-center px-4">
        <div className="bg-white rounded-2xl border border-emerald-400 shadow-xl p-8 max-w-md w-full relative animate-fade-in">
          <button
            onClick={() => setMostrarFrase(false)}
            className="absolute top-3 right-3 text-gray-400 hover:text-gray-600 text-xl font-bold cursor-pointer"
            aria-label="Cerrar"
          >
            ×
          </button>
          <h2 className="text-xl font-bold text-emerald-700 mb-4 text-center">
            Tu frase de hoy 💬
          </h2>
          <p className="text-gray-700 text-center text-lg italic">
            {fraseSeleccionada}
          </p>
        </div>
      </div>
    )}
    </div>
  );
}

export default DashboardPage;
