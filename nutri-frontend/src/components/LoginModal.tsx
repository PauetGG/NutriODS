import { useState } from "react";
import { validarEmail, validarContraseña } from "../utils/validation";
import { useAuth } from "../context/useAuth";

type LoginModalProps = {
  onClose: () => void;
  onOpenRegister: () => void;
};

function LoginModal({ onClose, onOpenRegister }: LoginModalProps) {
  const [identificador, setIdentificador] = useState("");
  const [contraseña, setContraseña] = useState("");
  const [error, setError] = useState<string | null>(null);

  const { login } = useAuth();

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();

    let identificadorError: string | null = null;

    if (identificador.includes("@")) {
      identificadorError = validarEmail(identificador);
    } else if (identificador.trim() === "") {
      identificadorError = "El nombre de usuario es obligatorio";
    }

    const passError = validarContraseña(contraseña);

    if (identificadorError || passError) {
      setError(identificadorError || passError || "");
      return;
    }

    setError(null);

    try {
      const response = await fetch("http://localhost:8080/api/auth/login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ identificador, contraseña }),
      });

      if (!response.ok) {
        throw new Error("Credenciales incorrectas");
      }

      const data = await response.json();

      const username = data.username || data[0]?.username;
      const nombre = data.nombre || data[0]?.nombre;

      if (data?.id && data?.username && data?.nombre) {
        login(data.id, data.username, data.nombre); // 👈 Ahora incluye el ID
        console.log("Login exitoso:", { username, nombre });
        onClose();
      } else {
        throw new Error("Datos de usuario incompletos en la respuesta");
      }
    } catch (err: unknown) {
      if (err instanceof Error) {
        setError(err.message);
      } else {
        setError("Error desconocido al iniciar sesión");
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

        <h2 className="text-2xl font-bold mb-4 text-green-700">Iniciar Sesión</h2>

        <form onSubmit={handleLogin}>
          <input
            type="text"
            placeholder="Correo o nombre de usuario"
            value={identificador}
            onChange={(e) => setIdentificador(e.target.value)}
            className="w-full mb-3 p-2 border rounded"
            required
          />

          <input
            type="password"
            placeholder="Contraseña"
            value={contraseña}
            onChange={(e) => setContraseña(e.target.value)}
            className="w-full mb-4 p-2 border rounded"
            required
          />

          {error && <p className="text-red-600 text-sm mb-2">{error}</p>}

          <button
            type="submit"
            className="w-full bg-green-600 text-white py-2 rounded hover:bg-green-700"
          >
            Entrar
          </button>
        </form>

        <p className="mt-4 text-sm text-gray-600 text-center">
          ¿No tienes cuenta?{" "}
          <span
            className="text-green-600 hover:underline cursor-pointer"
            onClick={() => {
              onClose();
              onOpenRegister();
            }}
          >
            Regístrate aquí
          </span>
        </p>
      </div>
    </div>
  );
}

export default LoginModal;
