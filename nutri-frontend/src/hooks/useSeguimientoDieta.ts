import { useCallback, useEffect, useState } from "react";

export type Seguimiento = {
  id: number;
  diaSemana: string;
  comida: string;
  porciones: number;
  consumido: boolean;
  notas: string;
  fecha: string;
  comidaModelo: {
    nombre: string;
    caloriasTotales: number;
    ingredientes: {
      id: number;
      ingrediente: {
        id: number;
        nombre: string;
      };
      cantidad: number;
      unidad: string;
    }[];
  };
};

export function useSeguimientoDieta(dietaId: number) {
  const [seguimiento, setSeguimiento] = useState<Seguimiento[]>([]);
  const [fechaInicioDieta, setFechaInicioDieta] = useState<Date | null>(null);

  const fetchSeguimiento = useCallback(async () => {
    try {
      const [resSeguimiento, resDieta] = await Promise.all([
        fetch(`http://localhost:8080/api/seguimiento-dieta/dieta/${dietaId}`),
        fetch(`http://localhost:8080/api/dietas/${dietaId}`),
      ]);
      const dataSeguimiento = await resSeguimiento.json();
      const dataDieta = await resDieta.json();

      setSeguimiento(dataSeguimiento);
      setFechaInicioDieta(new Date(dataDieta.created));
    } catch (err) {
      console.error("Error cargando seguimiento:", err);
    }
  }, [dietaId]);

  useEffect(() => {
    if (dietaId) fetchSeguimiento();
  }, [fetchSeguimiento, dietaId]);

  // ✅ Filtrado hasta el día anterior
  const hoy = new Date();
  hoy.setHours(0, 0, 0, 0);
  const seguimientoFiltrado = seguimiento.filter(
    (s) => new Date(s.fecha) < hoy
  );

  // ✅ Estadísticas globales
  const totalComidasPlanificadas = seguimientoFiltrado.length;
  const totalComidasConsumidas = seguimientoFiltrado.filter((s) => s.consumido).length;

  const totalCaloriasConsumidas = seguimientoFiltrado
    .filter((s) => s.consumido)
    .reduce((sum, s) => sum + s.comidaModelo.caloriasTotales, 0);

  const mediaCaloriasPorComida =
    totalComidasConsumidas > 0
      ? totalCaloriasConsumidas / totalComidasConsumidas
      : 0;

  const notasContadas: Record<string, number> = {};
  seguimientoFiltrado.forEach((s) => {
    const nota = s.notas?.trim();
    if (nota) {
      notasContadas[nota] = (notasContadas[nota] || 0) + 1;
    }
  });

  const notasFrecuentes = Object.entries(notasContadas).map(
    ([nota, veces]) => ({
      nota,
      veces,
    })
  );

  return {
    seguimiento,
    setSeguimiento,
    fechaInicioDieta,
    fetchSeguimiento,

    // Nuevos datos globales
    seguimientoFiltrado,
    totalComidasPlanificadas,
    totalComidasConsumidas,
    totalCaloriasConsumidas,
    mediaCaloriasPorComida,
    notasFrecuentes,
  };
}
