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
    <div className="max-w-md mx-auto mt-10 p-8 bg-white rounded-xl shadow-lg">
      <h2 className="text-3xl font-bold mb-6 text-center text-gray-800">
        Iniciar sesión
      </h2>
      <form onSubmit={handleSubmit} className="space-y-6" noValidate>
        {error && (
          <p className="text-red-600 text-center font-semibold">{error}</p>
        )}
        <div>
          <label
            htmlFor="correo"
            className="block text-sm font-medium text-gray-700"
          >
            Correo
          </label>
          <input
            id="correo"
            type="email"
            value={correo}
            onChange={(e) => setCorreo(e.target.value)}
            className="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
            required
          />
        </div>
        <div>
          <label
            htmlFor="contraseña"
            className="block text-sm font-medium text-gray-700"
          >
            Contraseña
          </label>
          <input
            id="contraseña"
            type="password"
            value={contraseña}
            onChange={(e) => setContraseña(e.target.value)}
            className="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
            required
          />
        </div>
        <button
          type="submit"
          className="w-full bg-blue-600 text-white py-3 rounded-md font-semibold hover:bg-blue-700 transition duration-300"
        >
          Iniciar sesión
        </button>
      </form>
    </div>
  );
};

export default Login;
