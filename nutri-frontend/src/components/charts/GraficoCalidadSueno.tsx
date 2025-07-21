import {
  ResponsiveContainer,
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
} from "recharts";

interface DatosCalidadSueno {
  fecha: string;
  calidadSueno: number;
}

interface Props {
  datos: DatosCalidadSueno[];
}

function GraficoCalidadSueno({ datos }: Props) {
  const datosOrdenados = [...datos].sort(
    (a, b) => new Date(a.fecha).getTime() - new Date(b.fecha).getTime()
  );

  const datosFormateados = datosOrdenados.map((d) => ({
    ...d,
    fecha: new Date(d.fecha).toLocaleDateString(), // formato dd/mm/aaaa
  }));

  return (
    <div className="bg-white rounded-lg shadow p-4">
      <h3 className="text-lg font-semibold mb-4 text-blue-800">Calidad del sueño</h3>
      <ResponsiveContainer width="100%" height={300}>
        <BarChart data={datosFormateados}>
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="fecha" tick={{ fill: "#6b7280" }} />
          <YAxis domain={[0, 5]} tick={{ fill: "#6b7280" }} />
          <Tooltip />
          <Bar
            dataKey="calidadSueno"
            fill="#10b981"
            name="Calidad del sueño"
            radius={[6, 6, 0, 0]}
            barSize={35}
          />
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
}

export default GraficoCalidadSueno;
