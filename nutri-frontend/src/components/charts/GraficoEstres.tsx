import {
  ResponsiveContainer,
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
} from "recharts";

interface DatosEstres {
  fecha: string;
  estres: number;
}

interface Props {
  datos: DatosEstres[];
}

function GraficoEstres({ datos }: Props) {
  const datosOrdenados = [...datos].sort(
    (a, b) => new Date(a.fecha).getTime() - new Date(b.fecha).getTime()
  );

  const datosFormateados = datosOrdenados.map((d) => {
    const date = new Date(d.fecha);
    const dia = date.getDate().toString().padStart(2, "0");
    const mes = (date.getMonth() + 1).toString().padStart(2, "0");
    return {
      ...d,
      fecha: `${dia}/${mes}`, // formato dd/mm
    };
  });

  return (
    <div className="bg-white rounded-lg shadow p-4">
      <h3 className="text-lg font-semibold mb-4 text-blue-800">Evolución del Estrés</h3>
      <ResponsiveContainer width="100%" height={300}>
        <LineChart data={datosFormateados}>
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="fecha" tick={{ fill: "#6b7280" }} />
          <YAxis domain={[0, 5]} tick={{ fill: "#6b7280" }} />
          <Tooltip />
          <Line
            type="monotone"
            dataKey="estres"
            stroke="#ef4444"
            strokeWidth={2}
            dot={{ r: 4 }}
            activeDot={{ r: 6 }}
            name="Nivel de Estrés"
          />
        </LineChart>
      </ResponsiveContainer>
    </div>
  );
}

export default GraficoEstres;
