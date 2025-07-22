import { useEffect, useState } from "react";
import type { SeguimientoFisico } from "../types/SeguimientoFisico";

export function useEstadisticasFisicas() {
  const [datos, setDatos] = useState<SeguimientoFisico[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    setLoading(true);
    fetch("/api/seguimiento-fisico")
      .then((res) => {
        if (!res.ok) throw new Error("Error al obtener los datos");
        return res.json();
      })
      .then((data) => {
        setDatos(data);
        setLoading(false);
      })
      .catch((err) => {
        setError(err.message);
        setLoading(false);
      });
  }, []);

  // 1. Evolución del peso corporal
  const pesoEvolucion = datos
    .slice() // copia para no mutar
    .sort((a, b) => new Date(a.fecha).getTime() - new Date(b.fecha).getTime())
    .map((d) => ({
      fecha: d.fecha,
      peso: d.peso,
    }));

  // 2. Velocidad y tiempo en entrenos de resistencia
  const entrenosResistencia = datos
    .filter((d) => d.velocidad !== null && d.tiempo !== null)
    .sort((a, b) => new Date(a.fecha).getTime() - new Date(b.fecha).getTime())
    .map((d) => ({
      fecha: d.fecha,
      velocidad: d.velocidad,
      tiempo: d.tiempo,
    }));

  // 3. Calistenia: repeticiones máximas por tipo de ejercicio
  const repeticionesCalistenia: Record<string, number> = {};
  datos.forEach((d) => {
    d.calisteniaEjercicios?.forEach((ej) => {
      if (
        !repeticionesCalistenia[ej.ejercicio] ||
        ej.repeticiones > repeticionesCalistenia[ej.ejercicio]
      ) {
        repeticionesCalistenia[ej.ejercicio] = ej.repeticiones;
      }
    });
  });

  // 4. Gimnasio: máximo peso levantado por zona muscular
  const pesoGimnasio: Record<string, number> = {};
  datos.forEach((d) => {
    d.gimnasioEjercicios?.forEach((ej) => {
      if (
        !pesoGimnasio[ej.zona] ||
        ej.peso > pesoGimnasio[ej.zona]
      ) {
        pesoGimnasio[ej.zona] = ej.peso;
      }
    });
  });

  return {
    datos,
    loading,
    error,
    pesoEvolucion,
    entrenosResistencia,
    repeticionesCalistenia,
    pesoGimnasio,
  };
}
