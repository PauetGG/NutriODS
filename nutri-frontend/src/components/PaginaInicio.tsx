import React, { useState, useRef, useEffect } from "react";
import RegistroUsuario from "./RegistroUsuario";
import Login from "./Login";
import Recetario from "./Recetario";

const PaginaInicio = () => {
  const [mostrarFormulario, setMostrarFormulario] = useState<"login" | "registro" | null>(null);
  const [mostrarRecetario, setMostrarRecetario] = useState(false);

  // Para cámara
  const [mostrarCamara, setMostrarCamara] = useState(false);
  const videoRef = useRef<HTMLVideoElement>(null);
  const streamRef = useRef<MediaStream | null>(null);

  useEffect(() => {
    if (mostrarCamara) {
      // Abrir cámara
      navigator.mediaDevices.getUserMedia({ video: true })
        .then((stream) => {
          streamRef.current = stream;
          if (videoRef.current) {
            videoRef.current.srcObject = stream;
            videoRef.current.play();
          }
        })
        .catch(() => alert("No se pudo acceder a la cámara."));
    } else {
      // Parar cámara si se cierra
      if (streamRef.current) {
        streamRef.current.getTracks().forEach(track => track.stop());
        streamRef.current = null;
      }
    }
  }, [mostrarCamara]);

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
        <div className="text-2xl font-bold text-green-700">NutriODS</div>

        <nav className="hidden md:flex space-x-6 text-gray-700 font-medium">
          <a href="#" className="hover:text-green-600">
            Inicio
          </a>
          <a href="#" className="hover:text-green-600">
            Servicios
          </a>
          <a href="#" className="hover:text-green-600">
            Contacto
          </a>
        </nav>

        <div className="flex items-center space-x-4">
          {/* Buscador */}
          <button className="text-gray-600 hover:text-green-600" title="Buscar">
            🔍
          </button>

          {/* Ícono libro para abrir recetario */}
          <button
            onClick={() => setMostrarRecetario(true)}
            className="text-gray-600 hover:text-green-600 text-2xl"
            title="Recetario de dietas"
            aria-label="Abrir recetario"
          >
            📚
          </button>

          {/* Icono cámara: abre modal con cámara */}
          <button
            onClick={() => setMostrarCamara(true)}
            className="text-gray-600 hover:text-pink-500 text-2xl"
            title="Abrir cámara"
            aria-label="Abrir cámara"
          >
            📸
          </button>

          {/* Botón login */}
          <button
            onClick={() => setMostrarFormulario("login")}
            className="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-lg font-semibold"
          >
            Iniciar sesión
          </button>
        </div>
      </header>

      {/* Contenido central */}
      <main className="relative z-10 flex flex-col items-center justify-center text-center pt-32 px-6">
        {!mostrarRecetario ? (
          <>
            <h1 className="text-5xl font-bold text-white drop-shadow-lg mb-4">
              Bienvenido a NutriODS
            </h1>
            <p className="text-xl text-white drop-shadow-md mb-8 max-w-2xl">
              Tu plataforma de confianza para mejorar tu salud, agendar citas y seguir tu nutrición día a día.
            </p>
            <button
              onClick={() => setMostrarFormulario("registro")}
              className="bg-white hover:bg-gray-100 text-green-700 font-bold py-3 px-6 rounded-full shadow-lg"
            >
              ¡Regístrate gratis!
            </button>
          </>
        ) : (
          <>
            {/* Aquí eliminamos el botón volver */}
            <Recetario />
          </>
        )}
      </main>

      {/* Modal para login o registro */}
      {mostrarFormulario && (
        <div className="fixed inset-0 bg-black bg-opacity-60 flex items-center justify-center z-40">
          <div className="bg-white p-8 rounded-xl shadow-xl w-full max-w-md relative">
            <button
              onClick={() => setMostrarFormulario(null)}
              className="absolute top-2 right-4 text-xl font-bold text-gray-500 hover:text-red-500"
              aria-label="Cerrar formulario"
            >
              ✖
            </button>

            {mostrarFormulario === "login" ? (
              <>
                <h2 className="text-xl font-bold mb-4 text-center text-green-700">
                  Iniciar sesión
                </h2>
                <Login onLoginExitoso={() => alert("Sesión iniciada")} />
                <p className="mt-4 text-sm text-center">
                  ¿No tienes cuenta?{" "}
                  <button
                    onClick={() => setMostrarFormulario("registro")}
                    className="text-blue-600 hover:underline"
                  >
                    Regístrate
                  </button>
                </p>
              </>
            ) : (
              <>
                <h2 className="text-xl font-bold mb-4 text-center text-green-700">
                  Registro
                </h2>
                <RegistroUsuario onRegistroExitoso={() => setMostrarFormulario(null)} />
                <p className="mt-4 text-sm text-center">
                  ¿Ya tienes cuenta?{" "}
                  <button
                    onClick={() => setMostrarFormulario("login")}
                    className="text-blue-600 hover:underline"
                  >
                    Inicia sesión
                  </button>
                </p>
              </>
            )}
          </div>
        </div>
      )}

      {/* Modal para cámara */}
      {mostrarCamara && (
        <div className="fixed inset-0 bg-black bg-opacity-80 flex flex-col items-center justify-center z-50 p-4">
          <video
            ref={videoRef}
            className="rounded-lg shadow-lg max-w-full max-h-[80vh]"
            autoPlay
            playsInline
          />
          <button
            onClick={() => setMostrarCamara(false)}
            className="mt-4 px-6 py-3 bg-red-600 text-white rounded-lg hover:bg-red-700 transition"
          >
            Cerrar cámara
          </button>
        </div>
      )}
    </div>
  );
};

export default PaginaInicio;
