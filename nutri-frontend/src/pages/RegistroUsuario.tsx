import { useState } from "react";

interface Props {
  onRegistroExitoso: () => void;
}

const RegistroUsuario = ({ onRegistroExitoso }: Props) => {
  const [correo, setCorreo] = useState("");
  const [contraseña, setContraseña] = useState("");
  const [error, setError] = useState("");

  const handleRegistro = (e: React.FormEvent) => {
    e.preventDefault();
    setError("");

    if (!correo || !contraseña) {
      setError("Por favor completa todos los campos");
      return;
    }

    // Guardar usuario localmente para simular registro
    localStorage.setItem("usuario", JSON.stringify({ correo, contraseña }));

    onRegistroExitoso();
  };

  return (
    <div className="max-w-md mx-auto mt-10 p-8 bg-white rounded-xl shadow-lg">
      <h2 className="text-3xl font-bold mb-6 text-center text-gray-800">Registro</h2>
      <form onSubmit={handleRegistro} className="space-y-6" noValidate>
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
            placeholder="correo@ejemplo.com"
            value={correo}
            onChange={(e) => setCorreo(e.target.value)}
            required
            className="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
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
            placeholder="********"
            value={contraseña}
            onChange={(e) => setContraseña(e.target.value)}
            required
            className="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </div>
        <button
          type="submit"
          className="w-full bg-green-600 text-white py-3 rounded-md font-semibold hover:bg-green-700 transition duration-300"
        >
          Registrarse
        </button>
      </form>
    </div>
  );
};

export default RegistroUsuario;
