export type DatosUsuarioDTO = {
  altura: number | string;
  peso: number | string;
  fechaNacimiento: string; // formato ISO: "YYYY-MM-DD"
  genero: "masculino" | "femenino" | "otro" | "";
  objetivo: string;
  alergias: string[];
  enfermedades: string[];
  preferencias: string[];
  actividad: "sedentario" | "ligero" | "moderado" | "intenso" | "muy intenso" | "";
};
