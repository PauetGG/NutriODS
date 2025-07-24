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

interface CaloriasConsumidasCardProps {
  datos: { dia: string; objetivo: number; consumido: number }[];
}

export const CaloriasConsumidasCard: React.FC<CaloriasConsumidasCardProps> = ({ datos }) => {
  const diasOrden = ["lunes", "martes", "miércoles", "jueves", "viernes", "sábado", "domingo"];

  const data = datos
    .map((d) => {
      const dia = d.dia.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");
      return {
        name: dia.charAt(0).toUpperCase() + dia.slice(1),
        objetivo: Number(d.objetivo),
        consumido: Number(d.consumido),
        diferencia: Math.max(0, Number(d.objetivo) - Number(d.consumido)),
        indexOrden: diasOrden.indexOf(dia),
      };
    })
    .filter((d) => d.indexOrden !== -1)
    .sort((a, b) => a.indexOrden - b.indexOrden);

  return (
    <div className="bg-white rounded-lg shadow p-4">
      <h3 className="text-sm text-gray-500 mb-2">Calorías consumidas esta semana</h3>
      <div className="h-64">
        <ResponsiveContainer width="100%" height="100%">
          <AreaChart data={data} margin={{ top: 10, right: 30, left: 0, bottom: 0 }}>
            <CartesianGrid strokeDasharray="3 3" vertical={false} />
            <XAxis
              dataKey="name"
              interval={0}
              axisLine={false}
              tickLine={false}
              tick={{ fill: "#9CA3AF" }}
            />
            <YAxis
              axisLine={false}
              tickLine={false}
              tick={{ fill: "#9CA3AF" }}
              domain={[0, "dataMax + 200"]}
            />
            <Tooltip />
            <Legend />
            <Area
              type="monotone"
              dataKey="consumido"
              stroke="#3B82F6"
              fill="#DBEAFE"
              name="Consumido"
              stackId="1"
            />
            <Area
              type="monotone"
              dataKey="diferencia"
              stroke="none"
              fill="#FECACA"
              name="Diferencia"
              stackId="1"
            />
            <Area
              type="monotone"
              dataKey="objetivo"
              stroke="#10B981"
              strokeDasharray="5 5"
              fillOpacity={0}
              name="Objetivo"
            />
          </AreaChart>
        </ResponsiveContainer>
      </div>
    </div>
  );
};
