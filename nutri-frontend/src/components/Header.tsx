import { useState } from "react";
import logo from "../assets/logo.png";

function Header() {
  const [mostrarFormulario, setMostrarFormulario] = useState<"login" | "registro" | null>(null);

  return (
    <div className="min-h-screen bg-gray-100 relative">
      {/* Fondo con imagen */}
      <div className="absolute inset-0">
        <img
          src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1600&q=80"
          alt="Fondo"
          className="w-full h-full object-cover opacity-60"
        />
      </div>

      {/* Encabezado */}
      <header className="relative z-10 flex items-center justify-between px-6 py-4 bg-white bg-opacity-80 shadow-md">
        <div className="text-2xl font-bold text-green-700">
             <img src={logo} alt="Logo NutriODS" className="h-24 w-auto" /> </div>

        <nav className="hidden md:flex space-x-6 text-gray-700 font-medium">
          <a href="#" className="hover:text-green-600">Inicio</a>
          <a href="#" className="hover:text-green-600">Servicios</a>
          <a href="#" className="hover:text-green-600">Contacto</a>
        </nav>

        <div className="flex items-center space-x-4">
          <button className="text-gray-600 hover:text-green-600" title="Buscar">🔍</button>
          <button
            onClick={() => alert("Recetario abierto")}
            className="text-gray-600 hover:text-green-600 text-2xl"
            title="Recetario de dietas"
            aria-label="Abrir recetario"
          >
            📚
          </button>
          <button
            onClick={() => alert("Cámara abierta")}
            className="text-gray-600 hover:text-pink-500 text-2xl"
            title="Abrir cámara"
            aria-label="Abrir cámara"
          >
            📸
          </button>
          <button
            onClick={() => setMostrarFormulario("login")}
            className="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-lg font-semibold"
          >
            Iniciar sesión
          </button>
        </div>
      </header>

      {/* Contenido según mostrarFormulario */}
      <div className="relative z-10 flex justify-center mt-10">
        {mostrarFormulario === "login" && (
          <div className="bg-white p-6 rounded-lg shadow-lg w-80">
            <h2 className="text-xl font-bold text-gray-700">Login</h2>
            <input
              className="mt-3 w-full p-2 border rounded"
              placeholder="Email"
              type="email"
            />
            <input
              className="mt-3 w-full p-2 border rounded"
              placeholder="Contraseña"
              type="password"
            />
            <div className="flex justify-end mt-4 space-x-2">
              <button
                className="bg-gray-300 text-gray-700 px-3 py-1 rounded"
                onClick={() => setMostrarFormulario(null)}
              >
                Cancelar
              </button>
              <button className="bg-green-600 text-white px-3 py-1 rounded">Entrar</button>
            </div>
            <p className="mt-3 text-sm text-gray-600">
              ¿No tienes cuenta?{" "}
              <a
                href="#registro"
                className="text-green-600 hover:underline"
                onClick={(e) => {
                  e.preventDefault();
                  setMostrarFormulario("registro");
                }}
              >
                Regístrate
              </a>
            </p>
          </div>
        )}

        {mostrarFormulario === "registro" && (
          <div className="bg-white p-6 rounded-lg shadow-lg w-80">
            <h2 className="text-xl font-bold text-gray-700">Registro</h2>
            <input
              className="mt-3 w-full p-2 border rounded"
              placeholder="Email"
              type="email"
            />
            <input
              className="mt-3 w-full p-2 border rounded"
              placeholder="Contraseña"
              type="password"
            />
            <div className="flex justify-end mt-4 space-x-2">
              <button
                className="bg-gray-300 text-gray-700 px-3 py-1 rounded"
                onClick={() => setMostrarFormulario(null)}
              >
                Cancelar
              </button>
              <button className="bg-green-600 text-white px-3 py-1 rounded">Registrarse</button>
            </div>
            <p className="mt-3 text-sm text-gray-600">
              ¿Ya tienes cuenta?{" "}
              <a
                href="#login"
                className="text-green-600 hover:underline"
                onClick={(e) => {
                  e.preventDefault();
                  setMostrarFormulario("login");
                }}
              >
                Inicia sesión
              </a>
            </p>
          </div>
        )}
      </div>
    </div>
  );
}

export default Header;
