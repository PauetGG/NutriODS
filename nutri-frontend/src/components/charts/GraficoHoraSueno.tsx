import {
  ResponsiveContainer,
  AreaChart,
  Area,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ReferenceLine,
  Label
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
      <h3 className="text-lg font-semibold mb-4 text-blue-800">Horas de sueño</h3>
      <ResponsiveContainer width="100%" height={300}>
        <AreaChart data={datosFormateados}>
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="fecha" tick={{ fill: "#6b7280" }} />
          <YAxis domain={[0, 12]} tick={{ fill: "#6b7280" }} />
          <Tooltip />

          <ReferenceLine y={8} stroke="#facc15" strokeDasharray="3 3">
          <Label
            value="Recomendado (8h)"
            position="top"
            dy={18} // más abajo que antes
            fill="#000000" // letra negra
            fontSize={14} // más grande
            fontWeight={600}
          />
        </ReferenceLine>


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
