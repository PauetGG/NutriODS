import { useCallback, useEffect, useState } from "react";
import { useAuth } from "../context/useAuth";
import DatosUsuarioForm from "../components/DatosUsuarioForm";
import type { DatosUsuarioDTO } from "../types/DatosUsuarioDTO";
import { useNavigate } from "react-router-dom";

type DietaResumen = {
  id: number;
  nombre: string;
  descripcion: string;
  numeroComidasDia: number;
  created: string;
};

function DietaPage() {
  const { nombre, username, id } = useAuth();
  const [mostrarFormulario, setMostrarFormulario] = useState(false);
  const [datosUsuario, setDatosUsuario] = useState<DatosUsuarioDTO | null>(null);
  const [dietas, setDietas] = useState<DietaResumen[]>([]);
  const navigate = useNavigate();

  const fetchDietas = useCallback(async () => {
    if (!id) return;
    try {
      const res = await fetch(`http://localhost:8080/api/dietas/usuario/${id}`);
      if (!res.ok) throw new Error("Error al obtener dietas");
      const data: DietaResumen[] = await res.json();
      setDietas(data);
    } catch (error) {
      console.error("Error al cargar dietas:", error);
    }
  }, [id]);

  useEffect(() => {
    fetchDietas();
  }, [fetchDietas]);

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
    <div className="min-h-screen bg-gray-50 py-16 px-6 sm:px-10 md:px-24">
      <div className="max-w-3xl mx-auto text-center mb-14">
        <h1 className="text-5xl font-extrabold text-emerald-700 mb-5 leading-tight">
          ¡Tu Dieta Personalizada Empieza Hoy!
        </h1>
        <p className="text-lg sm:text-xl text-gray-700 mb-3">
          En <span className="font-semibold text-emerald-600">BioNut</span> te creamos una dieta completamente personalizada
          según tus alergias, objetivos, preferencias alimentarias y estilo de vida.
        </p>
        <p className="text-md sm:text-lg text-gray-600">
          🕒 Y lo mejor de todo: <span className="font-semibold text-gray-800">tu dieta tiene una duración de 3 meses</span> con
          seguimiento diario para que no te desvíes del camino. No es una dieta cualquiera... ¡es TU plan nutricional!
        </p>
      </div>

      <div className="w-full h-px bg-emerald-200 mb-10" />

      <div className="text-center">
        {nombre ? (
          <button
            onClick={handleClickGenerar}
            className="bg-emerald-600 hover:bg-emerald-700 text-white font-semibold py-3 px-8 rounded-xl text-lg shadow-lg transition"
          >
            Generar mi Dieta Personalizada
          </button>
        ) : (
          <p className="text-lg text-gray-700">
            🔒 Para generar tu dieta necesitas{" "}
            <span className="text-emerald-600 font-semibold underline">iniciar sesión</span>.
          </p>
        )}
      </div>

      {dietas.length > 0 && (
        <div className="max-w-3xl mx-auto mt-14">
          <h2 className="text-2xl font-bold text-emerald-700 mb-6 text-center">Tus dietas generadas</h2>
          <ul className="space-y-5">
            {dietas.map((dieta, index) => (
              <li
                key={dieta.id}
                onClick={() => navigate(`/seguimiento/${dieta.id}/dashboard`)}
                className="p-5 bg-white border border-gray-200 rounded-xl shadow hover:shadow-md transition cursor-pointer"
              >
                <div className="flex flex-col sm:flex-row sm:justify-between sm:items-center mb-1">
                  <p className="text-lg font-semibold text-gray-800">
                    Dieta {index + 1}: {dieta.nombre}
                  </p>
                  <span className="text-sm text-gray-400">
                    📅 Creada el: {new Date(dieta.created).toLocaleDateString()}
                  </span>
                </div>
                <p className="text-sm text-gray-600 mb-1">{dieta.descripcion}</p>
                <p className="text-sm text-gray-500">🍽️ Comidas al día: {dieta.numeroComidasDia}</p>
              </li>
            ))}
          </ul>
        </div>
      )}

      {mostrarFormulario && (
        <DatosUsuarioForm
          datosIniciales={datosUsuario}
          onClose={() => {
            setMostrarFormulario(false);
            fetchDietas();
          }}
        />
      )}
    </div>
  );
}

export default DietaPage;
