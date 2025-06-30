import { useState } from "react";
import {
  validarEmail,
  validarContraseña,
  validarUsername,
  validarNombre,
} from "../utils/validation";
import { useAuth } from "../context/useAuth"; // 👈 importar contexto

type RegisterModalProps = {
  onClose: () => void;
  onOpenLogin: () => void;
};

function RegisterModal({ onClose, onOpenLogin }: RegisterModalProps) {
  const [formData, setFormData] = useState({
    correo: "",
    contraseña: "",
    username: "",
    nombre: "",
    apellidos: "",
  });

  const [error, setError] = useState<string | null>(null);
  const { login } = useAuth(); // 👈 usar contexto

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleRegister = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);

    const errores = [
      validarNombre(formData.nombre),
      validarUsername(formData.username),
      validarEmail(formData.correo),
      validarContraseña(formData.contraseña),
    ].filter(Boolean);

    if (errores.length > 0) {
      setError(errores[0] as string);
      return;
    }

    try {
      const response = await fetch("http://localhost:8080/api/auth/register", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(formData),
      });

      if (!response.ok) {
        const message = await response.text();
        throw new Error(message || "Error al registrarse");
      }

      const data = await response.json();
      console.log("Registro exitoso:", data);

      // 👇 iniciamos sesión tras registrarse con el nombre recibido
      const nombre = data.nombre || data[0]?.nombre || formData.nombre;
      login(nombre);

      onClose();
    } catch (err: unknown) {
      if (err instanceof Error) {
        setError(err.message);
      } else {
        setError("Error desconocido al registrarse");
      }
    }
  };

  return (
    <div className="fixed inset-0 bg-opacity-50 backdrop-blur-sm flex items-center justify-center z-50">
      <div className="bg-white p-6 rounded-lg shadow-md w-96 relative">
        <button
          onClick={onClose}
          className="absolute top-2 right-2 text-gray-500 hover:text-gray-700 cursor-pointer"
        >
          ✕
        </button>

        <h2 className="text-2xl font-bold mb-4 text-green-700">Registro</h2>

        <form onSubmit={handleRegister}>
          <input
            type="text"
            name="nombre"
            placeholder="Nombre"
            value={formData.nombre}
            onChange={handleChange}
            className="w-full mb-3 p-2 border rounded"
            required
          />
          <input
            type="text"
            name="apellidos"
            placeholder="Apellidos"
            value={formData.apellidos}
            onChange={handleChange}
            className="w-full mb-3 p-2 border rounded"
          />
          <input
            type="text"
            name="username"
            placeholder="Nombre de usuario"
            value={formData.username}
            onChange={handleChange}
            className="w-full mb-3 p-2 border rounded"
            required
          />
          <input
            type="email"
            name="correo"
            placeholder="Correo electrónico"
            value={formData.correo}
            onChange={handleChange}
            className="w-full mb-3 p-2 border rounded"
            required
          />
          <input
            type="password"
            name="contraseña"
            placeholder="Contraseña"
            value={formData.contraseña}
            onChange={handleChange}
            className="w-full mb-4 p-2 border rounded"
            required
          />

          {error && <p className="text-red-600 text-sm mb-3">{error}</p>}

          <button
            type="submit"
            className="w-full bg-green-600 text-white py-2 rounded hover:bg-green-700"
          >
            Registrarse
          </button>
        </form>

        <p className="mt-4 text-sm text-gray-600 text-center">
          ¿Ya tienes cuenta?{" "}
          <span
            className="text-green-600 hover:underline cursor-pointer"
            onClick={() => {
              onClose();
              onOpenLogin();
            }}
          >
            Inicia sesión
          </span>
        </p>
      </div>
    </div>
  );
}

export default RegisterModal;
