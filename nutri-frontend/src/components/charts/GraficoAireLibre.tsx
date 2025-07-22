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

interface DatosAireLibre {
  fecha: string;
  aireLibre: number;
}

interface Props {
  datos: DatosAireLibre[];
}

function GraficoAireLibre({ datos }: Props) {
  const datosOrdenados = [...datos].sort(
    (a, b) => new Date(a.fecha).getTime() - new Date(b.fecha).getTime()
  );

  const datosFormateados = datosOrdenados.map((d) => ({
    ...d,
    fecha: new Date(d.fecha).toLocaleDateString(),
  }));

  return (
    <div className="bg-white rounded-lg shadow p-4">
      <h3 className="text-lg font-semibold mb-4 text-green-700">Minutos al aire libre</h3>
      <ResponsiveContainer width="100%" height={300}>
        <LineChart data={datosFormateados}>
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="fecha" tick={{ fill: "#6b7280" }} />
          <YAxis domain={[0, 180]} unit=" min" tick={{ fill: "#6b7280" }} />
          <Tooltip />
          <ReferenceLine y={30} stroke="#34d399" strokeDasharray="3 3" label="Mínimo recomendado (30 min)" />
          <Line
            type="monotone"
            dataKey="aireLibre"
            stroke="#22c55e"
            strokeWidth={2}
            dot={{ r: 4 }}
            activeDot={{ r: 6 }}
            name="Minutos al aire libre"
          />
        </LineChart>
      </ResponsiveContainer>
    </div>
  );
}

export default GraficoAireLibre;
