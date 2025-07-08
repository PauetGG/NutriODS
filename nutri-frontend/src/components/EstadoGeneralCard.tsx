interface EstadoGeneralCardProps {
  energia: number;
  estres: number;
  motivacion: number;
}

export const EstadoGeneralCard: React.FC<EstadoGeneralCardProps> = ({
  energia,
  estres,
  motivacion,
}) => {
  const getColor = (valor: number) => {
    if (valor >= 4) return "text-green-600";
    if (valor >= 2.5) return "text-yellow-600";
    return "text-red-600";
  };

  const getEmoji = (tipo: string) => {
    switch (tipo) {
      case "energía":
        return "⚡";
      case "estrés":
        return "😖";
      case "motivación":
        return "💪";
      default:
        return "";
    }
  };

  const items = [
    { label: "energía", valor: energia },
    { label: "estrés", valor: estres },
    { label: "motivación", valor: motivacion },
  ];

  return (
    <div className="bg-white rounded-lg shadow p-4">
      <h3 className="text-sm text-gray-500 mb-2">Estado general</h3>
      <div className="space-y-2">
        {items.map((item, idx) => (
          <div key={idx} className="flex items-center justify-between">
            <span className="capitalize font-medium text-gray-600">
              {getEmoji(item.label)} {item.label}
            </span>
            <span className={`font-semibold ${getColor(item.valor)}`}>
              {item.valor.toFixed(1)} / 5
            </span>
          </div>
        ))}
      </div>
    </div>
  );
};
