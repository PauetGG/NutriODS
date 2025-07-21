import { useEffect, useState } from "react";
import axios from "axios";
import type { SeguimientoMental } from "../types/SeguimientoHabitos"; // Ajusta ruta si es necesario

export function useEstadisticasMentales() {
  const [datos, setDatos] = useState<SeguimientoMental[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchDatos = async () => {
      try {
        setLoading(true);
        const res = await axios.get<SeguimientoMental[]>(
          "http://localhost:8080/api/seguimiento-habitos" // AJUSTA esta URL según tu backend
        );
        setDatos(res.data);
      } catch (err) {
        console.error("Error al cargar los datos mentales:", err);
        setError("Error al cargar los datos mentales");
      } finally {
        setLoading(false);
      }
    };

    fetchDatos();
  }, []);

  return {
    datos,
    loading,
    error,
  };
}
