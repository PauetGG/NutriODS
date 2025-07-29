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
import { isBefore, startOfToday } from "date-fns";

interface CaloriasConsumidasCardProps {
  datos: { fecha: string; objetivo: number; consumido: number }[];
}

export const CaloriasConsumidasCard: React.FC<CaloriasConsumidasCardProps> = ({ datos }) => {
  const hoy = startOfToday();
  
    const data = datos
      .filter((d) => isBefore((d.fecha), hoy))
      .map((d) => ({
        name: new Date(d.fecha).toLocaleDateString("es-ES", { weekday: "short", day: "numeric", month: "short" }),
        objetivo: d.objetivo,
        consumido: d.consumido,
        diferencia: d.consumido < d.objetivo ? d.objetivo - d.consumido : 0,
      }));

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
