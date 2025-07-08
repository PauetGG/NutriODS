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
  datos: { dia: string; total: number }[];
  objetivo?: number;
}

export const CaloriasConsumidasCard: React.FC<CaloriasConsumidasCardProps> = ({
  datos,
  objetivo = 2000,
}) => {
  // Convertimos tus datos a formato válido para recharts
  const data = datos.map((d) => ({
    name: d.dia,
    consumido: d.total,
    objetivo: objetivo,
  }));

  return (
    <div className="bg-white rounded-lg shadow p-4">
      <h3 className="text-sm text-gray-500 mb-2">Calorías consumidas esta semana</h3>
      <div className="h-64">
        <ResponsiveContainer width="100%" height="100%">
          <AreaChart data={data} margin={{ top: 10, right: 30, left: 0, bottom: 0 }}>
            <CartesianGrid strokeDasharray="3 3" vertical={false} />
            <XAxis dataKey="name" axisLine={false} tickLine={false} tick={{ fill: "#9CA3AF" }} />
            <YAxis axisLine={false} tickLine={false} tick={{ fill: "#9CA3AF" }} />
            <Tooltip />
            <Legend />
            <Area
              type="monotone"
              dataKey="consumido"
              stroke="#3B82F6"
              fill="#DBEAFE"
              name="Consumido"
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
