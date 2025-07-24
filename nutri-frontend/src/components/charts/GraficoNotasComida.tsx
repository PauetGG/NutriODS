import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  Tooltip,
  ResponsiveContainer,
  CartesianGrid,
} from "recharts";

interface GraficoNotasComidaProps {
  notas: string[];
}

const NOTAS_VALIDAS = [
  "He comido menos cantidad",
  "No me ha gustado",
  "Me ha sentado mal",
  "Me ha gustado mucho",
];

// Mapeo para mostrar etiquetas cortas en el eje X
const ETIQUETAS_CORTAS: Record<string, string> = {
  "He comido menos cantidad": "He comido menos",
  "No me ha gustado": "No me ha gustado",
  "Me ha sentado mal": "Me ha sentado mal",
  "Me ha gustado mucho": "Me ha encantado",
};

export const GraficoNotasComida: React.FC<GraficoNotasComidaProps> = ({ notas }) => {
  const conteo: Record<string, number> = {};

  NOTAS_VALIDAS.forEach((nota) => {
    conteo[nota] = 0;
  });

  notas.forEach((notaTexto) => {
    if (!notaTexto) return;

    const notasSeparadas = notaTexto.split(",").map((n) => n.trim());
    notasSeparadas.forEach((n) => {
      if (NOTAS_VALIDAS.includes(n)) {
        conteo[n] = (conteo[n] || 0) + 1;
      }
    });
  });

  const data = NOTAS_VALIDAS.map((nota) => ({
    nombre: ETIQUETAS_CORTAS[nota],
    frecuencia: conteo[nota],
  }));

  return (
    <div className="bg-white rounded-lg shadow p-4">
      <h3 className="text-sm text-gray-500 mb-2">Notas más repetidas</h3>
      <div className="h-64">
        <ResponsiveContainer width="100%" height="100%">
          <BarChart data={data}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis
              dataKey="nombre"
              tick={{ fontSize: 11 }}
              interval={0}
              height={60}
              tickLine={false}
            />
            <YAxis allowDecimals={false} />
            <Tooltip />
            <Bar dataKey="frecuencia" fill="#3B82F6" />
          </BarChart>
        </ResponsiveContainer>
      </div>
    </div>
  );
};
