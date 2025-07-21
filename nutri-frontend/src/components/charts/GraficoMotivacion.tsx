import {
  ResponsiveContainer,
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
} from "recharts";

interface DatosMotivacion {
  fecha: string;
  motivacion: number;
}

interface Props {
  datos: DatosMotivacion[];
}

function GraficoMotivacion({ datos }: Props) {
  const datosOrdenados = [...datos].sort(
    (a, b) => new Date(a.fecha).getTime() - new Date(b.fecha).getTime()
  );

  const datosFormateados = datosOrdenados.map((d) => ({
    ...d,
    fecha: new Date(d.fecha).toLocaleDateString(),
  }));

  return (
    <div className="bg-white rounded-lg shadow p-4">
      <h3 className="text-lg font-semibold mb-4 text-indigo-700">Motivación</h3>
      <ResponsiveContainer width="100%" height={300}>
        <LineChart data={datosFormateados}>
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="fecha" tick={{ fill: "#6b7280" }} />
          <YAxis domain={[0, 5]} tick={{ fill: "#6b7280" }} />
          <Tooltip />
          <Line
            type="monotone"
            dataKey="motivacion"
            stroke="#6366f1"
            strokeWidth={2}
            dot={{ r: 4 }}
            activeDot={{ r: 6 }}
            name="Motivación"
          />
        </LineChart>
      </ResponsiveContainer>
    </div>
  );
}

export default GraficoMotivacion;
