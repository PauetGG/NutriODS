import { useEffect, useState } from "react";
import axios from "axios";
import { CrearTemaForm } from "../components/CrearTemaForm";
import { useAuth } from "../context/useAuth";
import Swal from "sweetalert2";

interface TemaForo {
  id: number;
  titulo: string;
  contenido: string;
  categoria: string;
  num_respuestas: number;
  visitas: number;
  created: string;
  usuario: {
    username: string;
  };
}

const categorias = ["todos", "dieta", "recetas", "entrenamiento", "general"];

export default function ForoPage() {
  const [temas, setTemas] = useState<TemaForo[]>([]);
  const [categoriaSeleccionada, setCategoriaSeleccionada] = useState("todos");
  const [mostrarFormulario, setMostrarFormulario] = useState(false);
  const { id: idUsuario } = useAuth();

  // Cargar temas
  const cargarTemas = () => {
    axios
      .get("http://localhost:8080/api/foro/temas")
      .then((res) => setTemas(res.data))
      .catch((err) => console.error("Error al cargar los temas del foro", err));
  };

  useEffect(() => {
    cargarTemas();
  }, []);

  const temasFiltrados =
    categoriaSeleccionada === "todos"
      ? temas
      : temas.filter((t) => t.categoria === categoriaSeleccionada);

  // Crear tema
  const handleCrearTema = async (formData: { titulo: string; contenido: string; categoria: string }) => {
    if (!idUsuario) {
      Swal.fire({ icon: "error", title: "Error", text: "Debes iniciar sesión para crear un tema." });
      return;
    }
    try {
      await axios.post("http://localhost:8080/api/foro/temas", {
        usuario: { id: idUsuario },
        titulo: formData.titulo,
        contenido: formData.contenido,
        categoria: formData.categoria,
      });
      Swal.fire({ icon: "success", title: "¡Tema publicado!", text: "Tu tema se ha publicado correctamente." });
      setMostrarFormulario(false);
      cargarTemas();
    } catch (err) {
      Swal.fire({ icon: "error", title: "Error", text: "No se pudo publicar el tema." });
    }
  };

  return (
    <div className="p-8 bg-white min-h-screen">
      <div className="flex flex-col md:flex-row md:items-center md:justify-between mb-8 gap-4">
        <h1 className="text-3xl font-bold text-gray-800">Foro de la Comunidad</h1>
        <button
          onClick={() => setMostrarFormulario(true)}
          className="px-5 py-2 bg-gradient-to-r from-emerald-500 to-emerald-600 text-white rounded-full shadow hover:shadow-lg transition-all"
        >
          ✍️ Escribir en el foro
        </button>
      </div>

      {/* Formulario para crear tema */}
      {mostrarFormulario && (
        <CrearTemaForm onClose={() => setMostrarFormulario(false)} onSubmit={handleCrearTema} />
      )}

      {/* Filtros */}
      <div className="flex flex-wrap gap-3 mb-6">
        {categorias.map((cat) => (
          <button
            key={cat}
            onClick={() => setCategoriaSeleccionada(cat)}
            className={`px-4 py-1.5 rounded-full border text-sm transition-all ${
              categoriaSeleccionada === cat
                ? "bg-emerald-600 text-white border-emerald-600"
                : "bg-white text-gray-600 border-gray-300 hover:bg-gray-100"
            }`}
          >
            {cat.charAt(0).toUpperCase() + cat.slice(1)}
          </button>
        ))}
      </div>

      {/* Temas */}
      {temasFiltrados.length === 0 ? (
        <p className="text-gray-500 text-center mt-20">No hay temas disponibles por ahora.</p>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {temasFiltrados.map((tema) => (
            <div
              key={tema.id}
              className="bg-white border border-gray-200 rounded-lg shadow-md hover:shadow-lg p-6 transition-shadow"
            >
              <div className="flex justify-between items-center mb-3">
                <span className="text-xs font-semibold px-3 py-1 rounded-full bg-emerald-100 text-emerald-700 capitalize">
                  {tema.categoria}
                </span>
                <span className="text-sm text-gray-400">
                  {new Date(tema.created).toLocaleDateString("es-ES")}
                </span>
              </div>
              <h2 className="text-lg font-semibold text-gray-800 mb-2">{tema.titulo}</h2>
              <p className="text-sm text-gray-600 mb-4 line-clamp-3">{tema.contenido}</p>
              <div className="flex justify-between text-sm text-gray-500">
                <span>👤 {tema.usuario.username}</span>
                <span>💬 {tema.num_respuestas}</span>
                <span>👁️ {tema.visitas}</span>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
