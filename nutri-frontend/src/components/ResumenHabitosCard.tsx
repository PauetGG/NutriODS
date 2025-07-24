interface ResumenHabitosCardProps {
  agua: number;
  sueno: number;
  ejercicio: number;
}

export const ResumenHabitosCard: React.FC<ResumenHabitosCardProps> = ({
  agua,
  sueno,
  ejercicio,
}) => {
  const getColor = (valor: number) => {
    if (valor >= 4) return "text-green-600";
    if (valor >= 2) return "text-yellow-600";
    return "text-red-600";
  };

  const getEstado = (valor: number) => {
    if (valor >= 4) return "Cumplido ✅";
    if (valor >= 2) return "Regular ⚠️";
    return "Mejorable ❌";
  };

  const items = [
    { label: "Agua", emoji: "💧", valor: agua },
    { label: "Sueño", emoji: "😴", valor: sueno },
    { label: "Pasos", emoji: "🏃‍♂️", valor: ejercicio },
  ];

  return (
    <div className="bg-white rounded-lg shadow p-4">
      <h3 className="text-sm text-gray-500 mb-2">Resumen de hábitos</h3>
      <div className="space-y-2">
        {items.map((item, idx) => (
          <div key={idx} className="flex items-center justify-between">
            <span className="font-medium text-gray-600">
              {item.emoji} {item.label}
            </span>
            <span className={`text-sm font-semibold ${getColor(item.valor)}`}>
              {item.valor.toFixed(1)} – {getEstado(item.valor)}
            </span>
          </div>
        ))}
      </div>
    </div>
  );
};
