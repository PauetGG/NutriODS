import {
  ResponsiveContainer,
  AreaChart,
  Area,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ReferenceLine,
  Label,
} from "recharts";

interface DatosAgua {
  fecha: string;
  agua: number;
}

interface Props {
  datos: DatosAgua[];
}

function GraficoAgua({ datos }: Props) {
  const datosOrdenados = [...datos].sort(
    (a, b) => new Date(a.fecha).getTime() - new Date(b.fecha).getTime()
  );

  const datosFormateados = datosOrdenados.map((d) => {
    const date = new Date(d.fecha);
    const dia = date.getDate().toString().padStart(2, "0");
    const mes = (date.getMonth() + 1).toString().padStart(2, "0");
    return {
      ...d,
      fecha: `${dia}/${mes}`,
    };
  });

  return (
    <div className="bg-white rounded-lg shadow p-4">
      <h3 className="text-lg font-semibold mb-4 text-sky-700">Litros de agua diarios</h3>
      <ResponsiveContainer width="100%" height={300}>
        <AreaChart data={datosFormateados}>
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="fecha" tick={{ fill: "#6b7280" }} />
          <YAxis domain={[0, 5]} unit=" L" tick={{ fill: "#6b7280" }} />
          <Tooltip
            labelFormatter={(label) => `Fecha: ${label}`}
            formatter={(value: number) => [`${value} L`, "Agua"]}
          />
          <ReferenceLine y={2} stroke="#38bdf8" strokeDasharray="3 3">
            <Label
              value="Recomendado (2L)"
              position="top"
              dy={24} // más abajo
              fill="#000000"
              fontSize={14}
              fontWeight={600}
            />
          </ReferenceLine>
          <Area
            type="monotone"
            dataKey="agua"
            stroke="#0ea5e9"
            fill="#bae6fd"
            name="Litros de agua"
          />
        </AreaChart>
      </ResponsiveContainer>
    </div>
  );
}

export default GraficoAgua;
