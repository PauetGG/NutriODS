import { Doughnut } from "react-chartjs-2";
import {
  Chart as ChartJS,
  ArcElement,
  Tooltip,
  Legend,
  Filler,
  type ChartOptions,
} from "chart.js";
import React from "react";

ChartJS.register(ArcElement, Tooltip, Legend, Filler); // 👈 Asegúrate de incluir Filler

interface GraficoDoughnutProps {
  completadas: number;
  pendientes: number;
}

export const GraficoDoughnut: React.FC<GraficoDoughnutProps> = ({
  completadas,
  pendientes,
}) => {
  const total = completadas + pendientes;
  const porcentaje = total > 0 ? Math.round((completadas / total) * 100) : 0;

  const data = {
    labels: ["Completadas", "Pendientes"],
    datasets: [
      {
        data: [completadas, pendientes],
        backgroundColor: ["#10B981", "#E5E5E5"],
        borderWidth: 0,
        cutout: "80%",
      },
    ],
  };

  const options: ChartOptions<"doughnut"> = {
    cutout: "80%",
    plugins: {
      legend: {
        display: false,
      },
      tooltip: {
        enabled: false,
      },
    },
    responsive: true,
    maintainAspectRatio: false,
  };

  return (
    <div className="relative w-full h-full flex items-center justify-center">
      <Doughnut data={data} options={options} />
      <div
        className="absolute"
        style={{
          fontSize: "1.8rem",
          fontWeight: "bold",
          color: "#10B981",
        }}
      >
        {porcentaje}%
      </div>
    </div>
  );
};
