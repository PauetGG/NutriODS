import {
  ResponsiveContainer,
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ReferenceLine,
} from "recharts";

interface DatosPasos {
  fecha: string;
  pasos: number;
}

interface Props {
  datos: DatosPasos[];
}

function GraficoPasos({ datos }: Props) {
  const datosOrdenados = [...datos].sort(
    (a, b) => new Date(a.fecha).getTime() - new Date(b.fecha).getTime()
  );

  const datosFormateados = datosOrdenados.map((d) => ({
    ...d,
    fecha: new Date(d.fecha).toLocaleDateString(),
  }));

  return (
    <div className="bg-white rounded-lg shadow p-4">
      <h3 className="text-lg font-semibold mb-4 text-yellow-700">Pasos diarios</h3>
      <ResponsiveContainer width="100%" height={300}>
        <LineChart data={datosFormateados}>
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="fecha" tick={{ fill: "#6b7280" }} />
          <YAxis domain={[0, 'auto']} tick={{ fill: "#6b7280" }} />
          <Tooltip />
          <ReferenceLine y={10000} stroke="#fbbf24" strokeDasharray="3 3" label="Recomendado (10k)" />
          <Line
            type="monotone"
            dataKey="pasos"
            stroke="#f59e0b"
            strokeWidth={2}
            dot={{ r: 4 }}
            activeDot={{ r: 6 }}
            name="Pasos"
          />
        </LineChart>
      </ResponsiveContainer>
    </div>
  );
}

export default GraficoPasos;
