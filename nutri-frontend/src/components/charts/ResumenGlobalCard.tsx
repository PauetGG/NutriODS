import React from "react";
import { GraficoDoughnut } from "../GraficoDoughnut";

interface ResumenGlobalCardProps {
  completadas: number;
  total: number;
}

export const ResumenGlobalCard: React.FC<ResumenGlobalCardProps> = ({
  completadas,
  total,
}) => {
  const pendientes = total - completadas;
  const porcentaje = total > 0 ? Math.round((completadas / total) * 100) : 0;

  const mensaje =
    porcentaje >= 90
      ? "¡Excelente constancia!"
      : porcentaje >= 75
      ? "Muy buen seguimiento"
      : porcentaje >= 50
      ? "Hay margen de mejora"
      : "Intenta ser más constante";

  return (
    <div className="bg-white rounded-lg shadow p-4">
      <h3 className="text-sm text-gray-500 mb-2">Resumen global</h3>
      <div className="flex flex-col items-center">
        <div className="w-32 h-32 mb-2">
          <GraficoDoughnut completadas={completadas} pendientes={pendientes} />
        </div>
        <p className="text-sm text-gray-600">
          {completadas} / {total} comidas completadas
        </p>
        <p className="text-xs text-gray-400 mt-1 italic">{mensaje}</p>
      </div>
    </div>
  );
};
