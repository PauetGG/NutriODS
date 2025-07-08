import React from "react";
import { GraficoDoughnut } from "./GraficoDoughnut";

interface ResumenSemanalCardProps {
  completadas: number;
  total: number;
}

export const ResumenSemanalCard: React.FC<ResumenSemanalCardProps> = ({
  completadas,
  total,
}) => {
  const pendientes = total - completadas;
  const porcentaje = total > 0 ? Math.round((completadas / total) * 100) : 0;
  const mensaje =
    porcentaje >= 80 ? "¡Muy bien!" : porcentaje >= 50 ? "Vamos mejorando" : "Hay que ponerse las pilas";

  return (
    <div className="bg-white rounded-lg shadow p-4">
      <h3 className="text-sm text-gray-500 mb-2">Resumen semanal</h3>
      <div className="flex flex-col items-center">
        <div className="w-32 h-32 mb-2">
          <GraficoDoughnut completadas={completadas} pendientes={pendientes} />
        </div>
        <p className="text-sm text-gray-600">{completadas} / {total} comidas completadas</p>
        <p className="text-xs text-gray-400 mt-1 italic">{mensaje}</p>
      </div>
    </div>
  );
};
