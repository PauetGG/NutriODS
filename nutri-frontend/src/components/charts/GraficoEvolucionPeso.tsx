import {
  CategoryScale,
  Chart as ChartJS,
  Legend,
  LineElement,
  LinearScale,
  PointElement,
  Title,
  Tooltip,
} from 'chart.js';
import { Line } from 'react-chartjs-2';

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
);

interface Props {
  datos: { fecha: string; peso: number }[];
}

function GraficoEvolucionPeso({ datos }: Props) {
  const data = {
    labels: datos.map((d) => new Date(d.fecha).toLocaleDateString()),
    datasets: [
      {
        label: 'Peso (kg)',
        data: datos.map((d) => d.peso),
        borderColor: 'rgb(54, 162, 235)',
        backgroundColor: 'rgba(54, 162, 235, 0.5)',
      },
    ],
  };

  const options = {
    responsive: true,
    plugins: {
      legend: {
        position: 'top' as const,
      },
      title: {
        display: true,
        text: 'Evolución del peso corporal',
      },
    },
  };

  return (
    <div className="bg-white p-4 rounded-lg shadow-md">
      <Line options={options} data={data} />
    </div>
  );
}

export default GraficoEvolucionPeso;
