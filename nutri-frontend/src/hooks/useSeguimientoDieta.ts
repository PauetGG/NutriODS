// hooks/useSeguimientoDieta.ts
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

  // ✅ Ahora también exportamos setSeguimiento
  return { seguimiento, setSeguimiento, fechaInicioDieta, fetchSeguimiento };
}
