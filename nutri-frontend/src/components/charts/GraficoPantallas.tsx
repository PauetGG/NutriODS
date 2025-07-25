import {
  ResponsiveContainer,
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
} from "recharts";

interface DatosPantallas {
  fecha: string;
  pantallas: number;
}

interface Props {
  datos: DatosPantallas[];
}

function GraficoPantallas({ datos }: Props) {
  const datosOrdenados = [...datos].sort(
    (a, b) => new Date(a.fecha).getTime() - new Date(b.fecha).getTime()
  );

  const datosFormateados = datosOrdenados.map((d) => ({
    ...d,
    fecha: new Date(d.fecha).toLocaleDateString("es-ES", {
      day: "2-digit",
      month: "2-digit",
    }),
  }));

  return (
    <div className="bg-white rounded-lg shadow p-4">
      <h3 className="text-lg font-semibold mb-4 text-purple-700">Horas frente a pantallas</h3>
      <ResponsiveContainer width="100%" height={300}>
        <BarChart data={datosFormateados}>
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="fecha" tick={{ fill: "#6b7280" }} />
          <YAxis domain={[0, 6]} unit=" h" tick={{ fill: "#6b7280" }} />
          <Tooltip />


          <Bar
            dataKey="pantallas"
            name="Horas de pantalla"
            fill="#c084fc"
            radius={[6, 6, 0, 0]}
            barSize={60} // más anchas aún
          />
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
}

export default GraficoPantallas;
