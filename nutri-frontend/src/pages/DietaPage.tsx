import { useState } from "react";
import { useAuth } from "../context/useAuth";
import DatosUsuarioForm from "../components/DatosUsuarioForm";
import type { DatosUsuarioDTO } from "../types/DatosUsuarioDTO";

function DietaPage() {
  const { nombre, username } = useAuth(); // ⬅️ añadimos username
  const [mostrarFormulario, setMostrarFormulario] = useState(false);
  const [datosUsuario, setDatosUsuario] = useState<DatosUsuarioDTO | null>(null);

  const obtenerDatosUsuario = async () => {
    if (!username) return;

    try {
      const response = await fetch(`http://localhost:8080/api/usuarios/username/${username}`);
      if (response.ok) {
        const data = await response.json();

        const datos: DatosUsuarioDTO = {
          altura: data.altura || "",
          peso: data.peso || "",
          fechaNacimiento: data.fechaNacimiento || "",
          genero: data.genero || "",
          objetivo: data.objetivo || "",
          alergias: data.alergias || [],
          enfermedades: data.enfermedades || [],
          preferencias: data.preferenciasComida || [],
          actividad: data.actividadFisica || "",
        };

        setDatosUsuario(datos);
      } else {
        setDatosUsuario(null);
      }
    } catch (error) {
      console.error("Error al obtener datos del usuario:", error);
      setDatosUsuario(null);
    }
  };

  const handleClickGenerar = async () => {
    await obtenerDatosUsuario();
    setMostrarFormulario(true);
  };

  return (
    <div className="min-h-screen bg-gray-50 py-12 px-6 sm:px-10 md:px-20">
      {/* Marketing de alto impacto */}
      <div className="max-w-3xl mx-auto text-center mb-10">
        <h1 className="text-4xl sm:text-5xl font-extrabold text-green-700 mb-4">
          ¡Descubre tu Dieta Ideal!
        </h1>
        <p className="text-lg sm:text-xl text-gray-700">
          Alimentarte bien nunca había sido tan fácil. En <span className="font-semibold text-green-600">BioNut</span>,
          creamos una dieta personalizada para ti en segundos: adaptada a tus alergias, objetivos, preferencias y estilo de vida.
        </p>
        <p className="mt-4 text-md sm:text-lg text-gray-600">
          Porque tu salud merece una guía profesional, deliciosa y hecha a medida.
        </p>
      </div>

      {/* Separador visual */}
      <div className="w-full h-px bg-green-200 mb-10" />

      {/* Área de generación de dieta */}
      <div className="text-center">
        {nombre ? (
          <button
            onClick={handleClickGenerar}
            className="bg-green-600 hover:bg-green-700 text-white font-bold py-3 px-6 rounded-lg text-lg shadow-md transition"
          >
            Generar mi Dieta Personalizada
          </button>
        ) : (
          <p className="text-lg text-gray-700">
            🔒 Para poder generar tu dieta, necesitas{" "}
            <span className="text-green-600 font-semibold">iniciar sesión</span>.
          </p>
        )}
      </div>

      {/* Modal del formulario */}
      {mostrarFormulario && (
        <DatosUsuarioForm
          datosIniciales={datosUsuario}
          onClose={() => setMostrarFormulario(false)}
        />
      )}
    </div>
  );
}

export default DietaPage;
