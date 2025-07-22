import {
  BarElement,
  CategoryScale,
  Chart as ChartJS,
  Legend,
  LinearScale,
  Title,
  Tooltip,
  type TooltipItem,
} from 'chart.js';
import { Bar } from 'react-chartjs-2';
import { useState } from 'react';

// ✅ Importa desde tu archivo de tipos
import type { GimnasioEjercicio } from '../../types/SeguimientoFisico';

ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend
);

// ✅ Tipo para gráfico resumen horizontal (por zona muscular o repeticiones máximas)
interface ResumenProps {
  titulo: string;
  label: string;
  datos: Record<string, number>;
}

// ✅ Tipo para gráfico de evolución por ejercicio (usando tu GimnasioEjercicio)
interface EvolucionProps {
  titulo: string;
  evolucionPorEjercicio: true;
  datosEvolucion: (GimnasioEjercicio & { fecha: string })[]; // añadimos fecha
}

// ✅ Unión de props
type Props = ResumenProps | EvolucionProps;

function GraficoFuerza(props: Props) {
  const isEvolucion =
    'evolucionPorEjercicio' in props && props.evolucionPorEjercicio;

  const ejerciciosUnicos = isEvolucion
    ? Array.from(new Set(props.datosEvolucion.map((e) => e.ejercicio))).sort()
    : [];

  const [ejercicioSeleccionado, setEjercicioSeleccionado] = useState(
    ejerciciosUnicos[0] || ''
  );

  if (isEvolucion) {
    const datosFiltrados = props.datosEvolucion
      .filter((e) => e.ejercicio === ejercicioSeleccionado)
      .sort((a, b) => new Date(a.fecha).getTime() - new Date(b.fecha).getTime());

    const data = {
      labels: datosFiltrados.map((d) =>
        new Date(d.fecha).toLocaleDateString()
      ),
      datasets: [
        {
          label: `Volumen (Peso + Reps) en ${ejercicioSeleccionado}`,
          data: datosFiltrados.map((d) => d.peso + d.reps),
          backgroundColor: 'rgba(255, 159, 64, 0.6)',
          borderColor: 'rgba(255, 159, 64, 1)',
          borderWidth: 1,
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
          text: props.titulo,
        },
        tooltip: {
          callbacks: {
            label: function (context: TooltipItem<'bar'>) {
              const index = context.dataIndex;
              const originalData = datosFiltrados[index];
              const total = context.parsed.y;
              return [
                `Total: ${total}`,
                `Peso: ${originalData.peso} kg`,
                `Reps: ${originalData.reps}`,
              ];
            },
          },
        },
      },
      scales: {
        y: {
          beginAtZero: true,
          title: {
            display: true,
            text: 'Volumen (Peso + Reps)',
          },
        },
      },
    };

    return (
      <div>
        <label className="block mb-2 font-semibold">Selecciona ejercicio:</label>
        <select
          className="mb-4 p-2 border rounded w-full"
          value={ejercicioSeleccionado}
          onChange={(e) => setEjercicioSeleccionado(e.target.value)}
        >
          {ejerciciosUnicos.map((ej) => (
            <option key={ej} value={ej}>
              {ej}
            </option>
          ))}
        </select>
        <Bar options={options} data={data} />
      </div>
    );
  }

  // Vista resumen horizontal
  const { titulo, label, datos } = props as ResumenProps;

  const barData = {
    labels: Object.keys(datos),
    datasets: [
      {
        label: label,
        data: Object.values(datos),
        backgroundColor: 'rgba(153, 102, 255, 0.6)',
        borderColor: 'rgba(153, 102, 255, 1)',
        borderWidth: 1,
      },
    ],
  };

  const barOptions = {
    indexAxis: 'y' as const,
    responsive: true,
    plugins: {
      legend: {
        position: 'top' as const,
        display: false,
      },
      title: {
        display: true,
        text: titulo,
      },
    },
    scales: {
      x: {
        beginAtZero: true,
      },
    },
  };

  return <Bar options={barOptions} data={barData} />;
}

export default GraficoFuerza;
