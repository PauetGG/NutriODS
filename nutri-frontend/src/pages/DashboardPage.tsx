import { useEffect, useState } from "react";
import { useSeguimientoDieta } from "../hooks/useSeguimientoDieta";
import { ResumenSemanalCard } from "../components/ResumenSemanalCard";
import { CaloriasConsumidasCard } from "../components/CaloriasConsumidasCard";
import { EstadoGeneralCard } from "../components/EstadoGeneralCard";
import { ResumenHabitosCard } from "../components/ResumenHabitosCard";
import { useParams } from "react-router-dom";

function DashboardPage() {
  const { dietaId } = useParams<{ dietaId: string }>();
  const dietaIdNumber = Number(dietaId);
  const { seguimiento } = useSeguimientoDieta(dietaIdNumber);

  const hoy = new Date();
  hoy.setHours(0, 0, 0, 0);

  // Calcular lunes de esta semana
  const lunes = new Date(hoy);
  const diaSemana = (hoy.getDay() + 6) % 7;
  lunes.setDate(hoy.getDate() - diaSemana);

  const comidasSemana = seguimiento.filter((s) => {
    const fecha = new Date(s.fecha.split("T")[0]);
    fecha.setHours(0, 0, 0, 0);
    return fecha >= lunes && fecha < hoy;
  });

  const total = comidasSemana.length;
  const completadas = comidasSemana.filter((s) => s.consumido).length;

  // 🔁 Calorías por día desde el backend
  const [caloriasSemanales, setCaloriasSemanales] = useState<
    { dia: string; objetivo: number; consumido: number }[]
  >([]);

  useEffect(() => {
    if (!isNaN(dietaIdNumber)) {
      fetch(`http://localhost:8080/api/seguimiento-dieta/calorias-semanales/dieta/${dietaIdNumber}`)
        .then((res) => res.json())
        .then(setCaloriasSemanales)
        .catch(console.error);
    }
  }, [dietaIdNumber]);

  // Simulación temporal de estado general
  const energia = 4.2;
  const estres = 2.8;
  const motivacion = 3.9;

  // Simulación temporal de hábitos
  const agua = 3.2;
  const sueno = 4.1;
  const ejercicio = 2.7;

  return (
    <div className="p-6 space-y-6">
      <h1 className="text-2xl font-bold">Resumen de tu seguimiento</h1>

      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
        <ResumenSemanalCard completadas={completadas} total={total} />
        <EstadoGeneralCard energia={energia} estres={estres} motivacion={motivacion} />
        <ResumenHabitosCard agua={agua} sueno={sueno} ejercicio={ejercicio} />
      </div>

      <CaloriasConsumidasCard datos={caloriasSemanales} />
    </div>
  );
}

export default DashboardPage;
