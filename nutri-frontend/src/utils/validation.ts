export function validarEmail(email: string): string | null {
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!email) return "El correo es obligatorio";
  if (!regex.test(email)) return "El formato del correo no es válido";
  return null;
}

export function validarContraseña(password: string): string | null {
  if (!password) return "La contraseña es obligatoria";
  if (password.length < 4) return "Debe tener al menos 4 caracteres";
  return null;
}

export function validarUsername(username: string): string | null {
  if (!username) return "El nombre de usuario es obligatorio";
  if (username.length < 2) return "Debe tener al menos 2 caracteres";
  return null;
}

export function validarNombre(nombre: string): string | null {
  if (!nombre) return "El nombre es obligatorio";
  if (nombre.length < 2) return "Debe tener al menos 2 caracteres";
  return null;
}