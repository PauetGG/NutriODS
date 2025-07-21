import React from "react";

interface AvatarHabitosProps {
  pasos: number;
  agua: number;
  suenoHoras: number;
  calidadSueno: number;
  animo: number;
  estres: number;
  motivacion: number;
  aireLibre: number;
  pantallas: number;
}

// Definición de animaciones en CSS-in-JS
const animaciones: Record<string, React.CSSProperties> = {
  feliz: {
    animation: 'bounce-emoji 1.2s infinite',
    display: 'inline-block',
  },
  neutral: {
    animation: 'side-emoji 1.5s infinite',
    display: 'inline-block',
  },
  triste: {
    animation: 'shake-emoji 0.7s infinite',
    display: 'inline-block',
  },
};

// Insertar keyframes en el documento solo una vez
if (typeof window !== 'undefined' && !document.getElementById('avatar-emoji-animations')) {
  const style = document.createElement('style');
  style.id = 'avatar-emoji-animations';
  style.innerHTML = `
    @keyframes bounce-emoji {
      0%, 100% { transform: translateY(0); }
      30% { transform: translateY(-10px) scale(1.1); }
      50% { transform: translateY(0); }
      70% { transform: translateY(-6px) scale(1.05); }
    }
    @keyframes side-emoji {
      0%, 100% { transform: translateX(0); }
      20% { transform: translateX(-4px); }
      50% { transform: translateX(4px); }
      80% { transform: translateX(-2px); }
    }
    @keyframes shake-emoji {
      0%, 100% { transform: rotate(0deg); }
      20% { transform: rotate(-10deg); }
      40% { transform: rotate(8deg); }
      60% { transform: rotate(-6deg); }
      80% { transform: rotate(4deg); }
    }
  `;
  document.head.appendChild(style);
}

function getScore(valor: number, rangos: [number, number], reverse = false) {
  if (!reverse) {
    if (valor < rangos[0]) return 0;
    if (valor < rangos[1]) return 0.5;
    return 1;
  } else {
    if (valor > rangos[1]) return 0;
    if (valor > rangos[0]) return 0.5;
    return 1;
  }
}

export const AvatarHabitos: React.FC<AvatarHabitosProps> = ({
  pasos,
  agua,
  suenoHoras,
  calidadSueno,
  animo,
  estres,
  motivacion,
  aireLibre,
  pantallas,
}) => {
  // Rangos propuestos
  const scores = [
    getScore(pasos, [7000, 10000]),
    getScore(agua, [1.5, 2]),
    getScore(suenoHoras, [7, 8]),
    getScore(calidadSueno, [3, 5]),
    getScore(animo, [3, 5]),
    getScore(estres, [2, 3], true), // reverse: menos es mejor
    getScore(motivacion, [3, 5]),
    getScore(aireLibre, [30, 60]),
    getScore(pantallas, [4, 6], true), // reverse: menos es mejor
  ];
  const media = scores.reduce((a, b) => a + b, 0) / scores.length;
  const porcentajeTexto = Math.round(media * 100);

  let cara = "😫";
  let anim = animaciones.triste;
  if (media > 0.8) {
    cara = "😄";
    anim = animaciones.feliz;
  } else if (media >= 0.4) {
    cara = "😐";
    anim = animaciones.neutral;
  }

  return (
    <div className="flex flex-col items-center justify-start bg-white p-6 rounded-xl shadow-md w-full max-w-xs">
      {/* Emoji animado */}
      <div className="text-7xl mb-4" style={anim}>{cara}</div>

      {/* Texto estado */}
      <div className="text-gray-700 font-semibold mb-2 text-sm">
        Media de hábitos: {porcentajeTexto}%
      </div>

      {/* Barra de progreso */}
      <div className="w-full bg-gray-200 rounded-full h-4">
        <div
          className="bg-green-500 h-4 rounded-full transition-all duration-300 ease-in-out"
          style={{ width: `${porcentajeTexto}%` }}
        ></div>
      </div>
    </div>
  );
};
