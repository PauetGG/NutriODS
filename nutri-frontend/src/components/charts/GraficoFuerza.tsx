import {
  BarElement,
  CategoryScale,
  Chart as ChartJS,
  Legend,
  LinearScale,
  Title,
  Tooltip,
  type TooltipItem,
} from "chart.js";
import { Bar } from "react-chartjs-2";
import { useState } from "react";
import type { GimnasioEjercicio } from "../../types/SeguimientoFisico";

ChartJS.register(CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend);

interface ResumenProps {
  titulo: string;
  label: string;
  datos: Record<string, number>;
}

interface EvolucionProps {
  titulo: string;
  evolucionPorEjercicio: true;
  datosEvolucion: (GimnasioEjercicio & { fecha: string })[];
}

type Props = ResumenProps | EvolucionProps;

function GraficoFuerza(props: Props) {
  const isEvolucion = "evolucionPorEjercicio" in props && props.evolucionPorEjercicio;

  const ejerciciosUnicos = isEvolucion
    ? Array.from(new Set(props.datosEvolucion.map((e) => e.ejercicio))).sort()
    : [];

  const [ejercicioSeleccionado, setEjercicioSeleccionado] = useState(ejerciciosUnicos[0] || "");

  // Clasificación manual
  const ejerciciosInferiores = [
    "adductores",
    "curl femoral",
    "extension cuadriceps",
    "gemelos",
    "hip trust",
    "peso muerto",
    "prensa",
    "sentadilla",
  ];

  const ejerciciosSuperiores = [
    "biceps",
    "elevaciones laterales",
    "face pull",
    "jalon pecho",
    "press banca",
    "press militar",
    "remo",
    "triceps",
  ];

  const superiores = ejerciciosUnicos.filter((ej) => ejerciciosSuperiores.includes(ej));
  const inferiores = ejerciciosUnicos.filter((ej) => ejerciciosInferiores.includes(ej));
  const otros = ejerciciosUnicos.filter(
    (ej) => !superiores.includes(ej) && !inferiores.includes(ej)
  );

  if (isEvolucion) {
    const datosFiltrados = props.datosEvolucion
      .filter((e) => e.ejercicio === ejercicioSeleccionado)
      .sort((a, b) => new Date(a.fecha).getTime() - new Date(b.fecha).getTime());

    const data = {
      labels: datosFiltrados.map((d) =>
        new Date(d.fecha).toLocaleDateString("es-ES", {
          day: "2-digit",
          month: "short",
        })
      ),
      datasets: [
        {
          label: `Volumen (Peso + Reps) en ${ejercicioSeleccionado}`,
          data: datosFiltrados.map((d) => d.peso + d.reps),
          backgroundColor: "rgba(255, 159, 64, 0.6)",
          borderColor: "rgba(255, 159, 64, 1)",
          borderWidth: 1,
          barPercentage: 0.5,
          categoryPercentage: 0.5,
        },
      ],
    };

    const options = {
      responsive: true,
      plugins: {
        legend: {
          position: "top" as const,
        },
        title: {
          display: true,
          text: props.titulo,
        },
        tooltip: {
          callbacks: {
            label: function (context: TooltipItem<"bar">) {
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
            text: "Volumen (Peso + Reps)",
          },
        },
      },
    };

    return (
      <div className="bg-white p-4 rounded-lg shadow-md">
        <label className="block mb-2 font-semibold">Selecciona ejercicio:</label>
        <select
          className="mb-4 p-2 border rounded w-full"
          value={ejercicioSeleccionado}
          onChange={(e) => setEjercicioSeleccionado(e.target.value)}
        >
          {superiores.length > 0 && (
            <optgroup label="Parte superior">
              {superiores.map((ej) => (
                <option key={ej} value={ej}>
                  {ej}
                </option>
              ))}
            </optgroup>
          )}
          {inferiores.length > 0 && (
            <optgroup label="Parte inferior">
              {inferiores.map((ej) => (
                <option key={ej} value={ej}>
                  {ej}
                </option>
              ))}
            </optgroup>
          )}
          {otros.length > 0 && (
            <optgroup label="Otros">
              {otros.map((ej) => (
                <option key={ej} value={ej}>
                  {ej}
                </option>
              ))}
            </optgroup>
          )}
        </select>

        <Bar options={options} data={data} />
      </div>
    );
  }

  // Gráfico resumen horizontal
  const { titulo, label, datos } = props as ResumenProps;

  const barData = {
    labels: Object.keys(datos),
    datasets: [
      {
        label: label,
        data: Object.values(datos),
        backgroundColor: "rgba(153, 102, 255, 0.6)",
        borderColor: "rgba(153, 102, 255, 1)",
        borderWidth: 1,
      },
    ],
  };

  const barOptions = {
    indexAxis: "y" as const,
    responsive: true,
    plugins: {
      legend: {
        position: "top" as const,
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

  return (
    <div className="bg-white p-4 rounded-lg shadow-md">
      <Bar options={barOptions} data={barData} />
    </div>
  );
}

export default GraficoFuerza;
