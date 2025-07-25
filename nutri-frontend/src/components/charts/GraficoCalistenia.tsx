import {
  ResponsiveContainer,
  AreaChart,
  Area,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
} from "recharts";
import { useState, useMemo } from "react";
import type { SeguimientoFisico } from "../../types/SeguimientoFisico"; // AJUSTA LA RUTA SI ES NECESARIO

interface Props {
  titulo: string;
  seguimientoFisico: SeguimientoFisico[];
}

function GraficoCalistenia({ titulo, seguimientoFisico }: Props) {
  const datosEvolucion = useMemo(() => {
    return seguimientoFisico.flatMap((sf) =>
      sf.calisteniaEjercicios.map((ej) => ({
        ejercicio: ej.ejercicio,
        fecha: sf.fecha,
        reps: ej.repeticiones,
      }))
    );
  }, [seguimientoFisico]);

  const ejerciciosUnicos = useMemo(
    () => Array.from(new Set(datosEvolucion.map((e) => e.ejercicio))).sort(),
    [datosEvolucion]
  );

  const [ejercicioSeleccionado, setEjercicioSeleccionado] = useState(
    ejerciciosUnicos[0] || ""
  );

  const datosFiltrados = useMemo(() => {
    const datosEjercicio = datosEvolucion
      .filter((e) => e.ejercicio === ejercicioSeleccionado)
      .sort((a, b) => new Date(a.fecha).getTime() - new Date(b.fecha).getTime());

    const maxReps = Math.max(...datosEjercicio.map((e) => e.reps), 0);

    return datosEjercicio.map((d) => {
      const date = new Date(d.fecha);
      const dia = date.getDate().toString().padStart(2, "0");
      const mes = (date.getMonth() + 1).toString().padStart(2, "0");
      return {
        fecha: `${dia}/${mes}`,
        repeticiones: d.reps,
        objetivo: maxReps,
      };
    });
  }, [ejercicioSeleccionado, datosEvolucion]);

  return (
    <div className="bg-white rounded-lg shadow p-4">
      <div className="mb-4">
        <label className="block mb-2 font-semibold">Selecciona ejercicio:</label>
        <select
          className="w-full p-2 border rounded"
          value={ejercicioSeleccionado}
          onChange={(e) => setEjercicioSeleccionado(e.target.value)}
        >
          {ejerciciosUnicos.map((ej) => (
            <option key={ej} value={ej}>
              {ej}
            </option>
          ))}
        </select>
      </div>

      <h3 className="text-sm text-gray-500 mb-2">{titulo}</h3>
      <div className="h-64">
        <ResponsiveContainer width="100%" height="100%">
          <AreaChart
            data={datosFiltrados}
            margin={{ top: 10, right: 30, left: 0, bottom: 0 }}
          >
            <CartesianGrid strokeDasharray="3 3" vertical={false} />
            <XAxis
              dataKey="fecha"
              interval={0}
              axisLine={false}
              tickLine={false}
              tick={{ fill: "#9CA3AF" }}
            />
            <YAxis
              axisLine={false}
              tickLine={false}
              tick={{ fill: "#9CA3AF" }}
              domain={[0, "dataMax + 2"]}
            />
            <Tooltip />
            <Legend />

            <Area
              type="monotone"
              dataKey="repeticiones"
              stroke="#3B82F6"
              fill="#DBEAFE"
              name="Repeticiones"
              stackId="1"
            />

            <Area
              type="monotone"
              dataKey="objetivo"
              stroke="#10B981"
              strokeDasharray="5 5"
              fillOpacity={0}
              name="Máximo"
            />
          </AreaChart>
        </ResponsiveContainer>
      </div>
    </div>
  );
}

export default GraficoCalistenia;
