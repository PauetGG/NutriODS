export interface GimnasioEjercicio {
  id: number;
  ejercicio: string;
  zona: string;
  peso: number;
  reps: number;
}

export interface CalisteniaEjercicio {
  id: number;
  ejercicio: string;   // <- este es el campo real del JSON
  repeticiones: number;
}

  
  export interface SeguimientoFisico {
    id: number;
    peso: number;
    fecha: string;
    velocidad: number | null;
    tiempo: number | null;
    gimnasioEjercicios: GimnasioEjercicio[];
    calisteniaEjercicios: CalisteniaEjercicio[];
    // ...otros campos si los necesitas
  }