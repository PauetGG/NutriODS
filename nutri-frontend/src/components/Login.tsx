import React, { useState } from "react";

type Props = {
  onLoginExitoso: () => void;
};

const Login: React.FC<Props> = ({ onLoginExitoso }) => {
  const [correo, setCorreo] = useState("");
  const [contraseña, setContraseña] = useState("");
  const [error, setError] = useState("");

  const validarEmail = (email: string) => {
    return /\S+@\S+\.\S+/.test(email);
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    if (!correo || !contraseña) {
      setError("Por favor completa todos los campos");
      return;
    }

    if (!validarEmail(correo)) {
      setError("Formato de correo inválido");
      return;
    }

    const usuarioGuardado = localStorage.getItem("usuario");
    if (!usuarioGuardado) {
      setError("No hay usuario registrado. Regístrate primero.");
      return;
    }

    const usuario = JSON.parse(usuarioGuardado);

    if (correo === usuario.correo && contraseña === usuario.contraseña) {
      setError("");
      alert("Login exitoso");
      onLoginExitoso();
    } else {
      setError("Correo o contraseña incorrectos");
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-tr from-green-100 via-green-50 to-green-100 p-4">
      <div
        className="
          max-w-md w-full p-8
          bg-white/30
          backdrop-blur-md
          rounded-2xl
          border border-white/40
          shadow-lg
          text-gray-800
        "
      >
        <h2 className="text-3xl font-extrabold mb-6 text-center tracking-wide text-green-800">
          Iniciar sesión
        </h2>
        <form onSubmit={handleSubmit} className="space-y-6" noValidate>
          {error && (
            <p className="text-red-600 text-center font-semibold">{error}</p>
          )}
          <div>
            <label
              htmlFor="correo"
              className="block text-sm font-semibold mb-1 text-green-700"
            >
              Correo
            </label>
            <input
              id="correo"
              type="email"
              value={correo}
              onChange={(e) => setCorreo(e.target.value)}
              className="
                w-full px-4 py-3 rounded-lg
                bg-white/60
                border border-green-300
                focus:outline-none focus:ring-2 focus:ring-green-500
                transition
              "
              required
            />
          </div>
          <div>
            <label
              htmlFor="contraseña"
              className="block text-sm font-semibold mb-1 text-green-700"
            >
              Contraseña
            </label>
            <input
              id="contraseña"
              type="password"
              value={contraseña}
              onChange={(e) => setContraseña(e.target.value)}
              className="
                w-full px-4 py-3 rounded-lg
                bg-white/60
                border border-green-300
                focus:outline-none focus:ring-2 focus:ring-green-500
                transition
              "
              required
            />
          </div>
          <button
            type="submit"
            className="
              w-full py-3
              bg-green-600 hover:bg-green-700
              text-white font-bold rounded-lg
              transition duration-300
            "
          >
            Iniciar sesión
          </button>
        </form>
      </div>
    </div>
  );
};

export default Login;
