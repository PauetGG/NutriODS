import {
  ResponsiveContainer,
  AreaChart,
  Area,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ReferenceLine
} from "recharts";

interface DatosSueno {
  fecha: string;
  suenoHoras: number;
}

interface Props {
  datos: DatosSueno[];
}

function GraficoHorasSueno({ datos }: Props) {
  const datosOrdenados = [...datos].sort(
    (a, b) => new Date(a.fecha).getTime() - new Date(b.fecha).getTime()
  );

  const datosFormateados = datosOrdenados.map((d) => ({
    ...d,
    fecha: new Date(d.fecha).toLocaleDateString(),
  }));

  return (
    <div className="bg-white rounded-lg shadow p-4">
      <h3 className="text-lg font-semibold mb-4 text-blue-800">Horas de sueño</h3>
      <ResponsiveContainer width="100%" height={300}>
        <AreaChart data={datosFormateados}>
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="fecha" tick={{ fill: "#6b7280" }} />
          <YAxis domain={[0, 12]} tick={{ fill: "#6b7280" }} />
          <Tooltip />
          <ReferenceLine y={8} stroke="#facc15" strokeDasharray="3 3" label="Recomendado (8h)" />

          <Area
            type="monotone"
            dataKey="suenoHoras"
            stroke="#3b82f6"
            fill="#dbeafe"
            name="Horas de sueño"
          />
        </AreaChart>
      </ResponsiveContainer>
    </div>
  );
}

export default GraficoHorasSueno;
