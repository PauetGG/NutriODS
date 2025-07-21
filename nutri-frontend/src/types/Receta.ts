export type Receta = {
  id: number;
  nombre: string;
  descripcion?: string;
  instrucciones: string;
  tiempoPreparacion: number;
  dificultad: "fácil" | "media" | "difícil";
  raciones: number;
  imagenUrl?: string;
  visible?: boolean;
  creado?: string;
  modificado?: string;
  ingredientes?: any[]; // Puedes tipar mejor si tienes la estructura de ingredientes
};