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

  const { seguimiento } = useSeguimientoDieta(dietaIdNumber);

  const [semanaActual, setSemanaActual] = useState(0);

  const hoy = new Date();
  hoy.setHours(0, 0, 0, 0);

  // Si hoy es domingo, lo tratamos como final de la semana anterior
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

  // 🔥 Mapeo manual de días a fecha de esta semana
  const diasMap = ["domingo", "lunes", "martes", "miércoles", "jueves", "viernes", "sábado"];
  const caloriasFiltradas = caloriasSemanales.filter((d) => {
    const index = diasMap.indexOf(d.dia.toLowerCase());
    if (index === -1) return false;
    const fecha = new Date(lunes);
    fecha.setDate(lunes.getDate() + index);
    return fecha >= lunes && fecha <= finSemana;
  });

  return (
    <div className="p-6 space-y-6">
      <h1 className="text-2xl font-bold mb-4">Resumen de tu seguimiento</h1>

      <div className="flex items-center justify-between max-w-sm mb-6">
        <button
          className="bg-gray-200 px-3 py-1 rounded hover:bg-gray-300"
          onClick={() => setSemanaActual((prev) => prev + 1)}
        >
          ← Semana anterior
        </button>
        <span className="font-semibold">
          Semana {semanaActual === 0 ? "actual" : `-${semanaActual}`}
        </span>
        {semanaActual > 0 && (
          <button
            className="bg-gray-200 px-3 py-1 rounded hover:bg-gray-300"
            onClick={() => setSemanaActual((prev) => prev - 1)}
          >
            Semana siguiente →
          </button>
        )}
      </div>

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
    </div>
  );
}

export default DashboardPage;
