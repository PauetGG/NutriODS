import { useEffect, useState } from "react";
import axios from "axios";
import { CrearTemaForm } from "../components/CrearTemaForm";
import { useAuth } from "../context/useAuth";
import { Link, useNavigate } from "react-router-dom";
import Swal from "sweetalert2";
import '@fontsource/montserrat/700.css';
import { FaRegComments, FaChevronDown, FaChevronUp, FaRegListAlt, FaRegFileAlt, FaPenFancy } from 'react-icons/fa';
import { motion, AnimatePresence } from 'framer-motion';
import { useRef } from 'react';

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

// Categorías válidas para el backend
const categoriasValidas = ["general", "dieta", "recetas", "entrenamiento"];
// Categorías para el filtro (incluye 'todos')
const categoriasFiltro = ["todos", ...categoriasValidas];

export default function ForoPage() {
  const [temas, setTemas] = useState<TemaForo[]>([]);
  const [categoriaSeleccionada, setCategoriaSeleccionada] = useState<string | null>(null);
  const [mostrarFormulario, setMostrarFormulario] = useState(false);
  const [mostrarTemasDropdown, setMostrarTemasDropdown] = useState(false);
  const [mostrarPostsDropdown, setMostrarPostsDropdown] = useState(false);
  const [vista, setVista] = useState<'recientes' | 'temas' | 'reglas'>('recientes');
  const { id: idUsuario } = useAuth();
  const navigate = useNavigate();

  const reglasRef = useRef<HTMLDivElement>(null);

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
    categoriaSeleccionada === null || categoriaSeleccionada === "todos"
      ? temas
      : temas.filter((t) => t.categoria === categoriaSeleccionada);

  // Get recent posts (last 5, for example)
  const postsRecientes = [...temas]
    .sort((a, b) => new Date(b.created).getTime() - new Date(a.created).getTime())
    .slice(0, 5);

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
      setCategoriaSeleccionada("todos");
      setVista("temas");
      cargarTemas();
    } catch (err) {
      console.error("Error al publicar el tema:", err);
      Swal.fire({
        icon: "error",
        title: "Error",
        text: "No se pudo publicar el tema.",
      });
    }
  };

  return (
    <div className="flex bg-white min-h-screen">
      {/* Sidebar */}
      <aside className="w-64 bg-gray-50 p-6 border-r border-gray-200">
        <div className="flex flex-col items-center mb-8">
          <motion.h3
            className="text-3xl font-bold mb-2 bg-gradient-to-r from-emerald-500 to-emerald-700 bg-clip-text text-transparent drop-shadow-lg font-[Montserrat,Arial,sans-serif] flex items-center gap-2 justify-center"
            initial={{ opacity: 0, y: -20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.7 }}
          >
            <FaRegComments className="text-emerald-500 drop-shadow" />
            Bionut <span className="font-black">Foro</span>
          </motion.h3>
          <span className="text-xs text-emerald-700 tracking-wide font-semibold">¡Comparte, aprende y crece!</span>
        </div>

        {/* Recent Posts as Button */}
        <div className="mb-4">
          <button
            onClick={() => {
              setMostrarTemasDropdown(false);
              setVista('recientes');
              setCategoriaSeleccionada(null);
            }}
            className={`w-full text-left px-4 py-2 mb-2 bg-white border border-emerald-200 rounded-lg text-gray-700 flex items-center gap-2 hover:bg-emerald-50 transition-all shadow-sm ${vista === 'recientes' ? 'bg-emerald-100 text-emerald-700 font-bold ring-2 ring-emerald-400' : ''}`}
          >
            <FaRegListAlt className="text-emerald-500 text-xl" />
            <span className="text-lg font-semibold">Posts recientes</span>
          </button>
        </div>

        {/* Topics Dropdown */}
        <div className="mb-4">
          <button
            onClick={() => {
              setMostrarPostsDropdown(false);
              setMostrarTemasDropdown((prev) => !prev);
            }}
            className="w-full text-left px-4 py-2 bg-white border border-emerald-200 rounded-lg text-gray-700 flex justify-between items-center hover:bg-emerald-50 transition-all shadow-sm"
          >
            <span className="flex items-center gap-2 text-lg font-semibold"><FaRegListAlt className="text-emerald-500" />Temas</span>
            {mostrarTemasDropdown ? <FaChevronUp /> : <FaChevronDown />}
          </button>
          <AnimatePresence initial={false}>
            {mostrarTemasDropdown && (
              <motion.div
                initial={{ height: 0, opacity: 0 }}
                animate={{ height: 'auto', opacity: 1 }}
                exit={{ height: 0, opacity: 0 }}
                transition={{ duration: 0.3, ease: 'easeInOut' }}
                className="overflow-hidden"
              >
                <div className="flex flex-col w-full bg-white border border-emerald-100 rounded-b-lg shadow-inner mt-1">
                  {categoriasFiltro.map((cat) => (
                    <button
                      key={cat}
                      onClick={() => {
                        setCategoriaSeleccionada(cat);
                        setVista('temas');
                        setMostrarTemasDropdown(false);
                      }}
                      className={`block w-full text-left px-4 py-2 text-sm capitalize transition-all ${
                        categoriaSeleccionada === cat && vista === 'temas' ? "bg-emerald-100 text-emerald-700 font-bold" : "text-gray-700 hover:bg-emerald-50"
                      }`}
                    >
                      {cat === "todos" ? "Todos los temas" : cat}
                    </button>
                  ))}
                </div>
              </motion.div>
            )}
          </AnimatePresence>
        </div>

        {/* Community Rules as Button */}
        <div className="mb-4" ref={reglasRef}>
          <button
            onClick={() => {
              setVista('reglas');
              setMostrarTemasDropdown(false);
              setCategoriaSeleccionada(null);
            }}
            className={`w-full text-left px-4 py-2 bg-white border border-emerald-200 rounded-lg text-gray-700 flex items-center gap-2 hover:bg-emerald-50 transition-all shadow-sm ${vista === 'reglas' ? 'bg-emerald-100 text-emerald-700 font-bold ring-2 ring-emerald-400' : ''}`}
          >
            <FaRegFileAlt className="text-emerald-500 text-xl" />
            <span className="text-lg font-semibold">Reglas de la comunidad</span>
          </button>
          <div className="mt-4">
            <button
              className="w-full text-left px-4 py-2 bg-white border border-emerald-200 rounded-lg text-gray-700 flex items-center gap-2 hover:bg-emerald-50 transition-all shadow-sm font-semibold text-lg"
              onClick={() => navigate('/soporte')}
            >
              <span className="text-emerald-500 text-xl">💬</span>
              Soporte / Ayudas
            </button>
          </div>
        </div>
        {/* Botón Publicar debajo de reglas */}
        <button
          onClick={() => {
            setMostrarFormulario(true);
            setVista('temas');
          }}
          className="w-full mt-2 px-4 py-2 bg-gradient-to-r from-green-400 via-emerald-500 to-emerald-700 text-white rounded-2xl shadow-xl hover:shadow-2xl transition-all font-bold text-lg flex items-center justify-center gap-2 transform hover:scale-105 active:scale-95 duration-150"
        >
          <FaPenFancy className="text-xl" />
          <span>Publicar</span>
        </button>
      </aside>

      {/* Main Content */}
      <div className="flex-1 p-8">
        {/* Mostrar solo una vista según el estado */}
        {vista === 'recientes' && (
          <div className="mb-8">
            <h2 className="text-xl font-bold text-emerald-700 mb-4">Posts recientes</h2>
            {postsRecientes.length === 0 ? (
              <p className="text-sm text-gray-500">No hay posts recientes.</p>
            ) : (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {postsRecientes.map((tema) => (
                  <AnimatePresence key={tema.id}>
                    <motion.div
                      initial={{ opacity: 0, y: 20 }}
                      animate={{ opacity: 1, y: 0 }}
                      exit={{ opacity: 0, y: 20 }}
                      transition={{ duration: 0.3 }}
                    >
                      <Link
                        to={`/foro/temas/${tema.id}`}
                        className="bg-white border border-emerald-200 rounded-xl shadow-md hover:shadow-xl p-6 transition-all block group"
                      >
                        <div className="flex justify-between items-center mb-3">
                          <span className="text-xs font-semibold px-3 py-1 rounded-full bg-emerald-100 text-emerald-700 capitalize">
                            {tema.categoria}
                          </span>
                          <span className="text-sm text-gray-400">
                            {new Date(tema.created).toLocaleDateString("es-ES")}
                          </span>
                        </div>
                        <h2 className="text-lg font-bold text-gray-800 mb-2 group-hover:text-emerald-700 transition-colors">
                          {tema.titulo}
                        </h2>
                        <p className="text-sm text-gray-600 mb-4 line-clamp-3">{tema.contenido}</p>
                        <div className="flex justify-between text-sm text-gray-500">
                          <span className="flex items-center gap-1"><FaRegComments className="inline" /> {tema.usuario.username}</span>
                          <span>🗨️ {tema.num_respuestas}</span>
                          <span>👁️ {tema.visitas}</span>
                        </div>
                      </Link>
                    </motion.div>
                  </AnimatePresence>
                ))}
              </div>
            )}
          </div>
        )}

        {vista === 'reglas' && (
          <>
            <div className="mb-4 max-w-2xl mx-auto">
              <div className="flex items-center gap-2 mb-4">
                <span className="text-3xl">📜</span>
                <h2 className="text-2xl font-extrabold text-emerald-700">Reglas de la Comunidad</h2>
              </div>
              <div className="bg-white/90 border border-emerald-200 rounded-2xl shadow-lg p-6 md:p-8 space-y-4">
                <p className="text-gray-700 text-base md:text-lg mb-2">
                  Bienvenido al foro de la comunidad. Este espacio ha sido creado para compartir experiencias, resolver dudas, aportar ideas y fomentar un ambiente saludable de aprendizaje y colaboración. Para garantizar una buena convivencia entre todos los miembros, te pedimos que respetes las siguientes normas:
                </p>
                <ol className="list-decimal list-inside text-emerald-900 space-y-3 pl-2">
                  <li>
                    <span className="font-bold">Respeta a los demás miembros.</span><br/>
                    El respeto mutuo es la base de toda comunidad sólida. No se tolerarán comentarios ofensivos, discriminatorios, provocaciones, insultos o actitudes hostiles hacia otros usuarios. Las diferencias de opinión son bienvenidas, siempre que se expresen de forma educada y constructiva.
                  </li>
                  <li>
                    <span className="font-bold">No publiques spam ni contenido promocional.</span><br/>
                    Este foro no es un espacio para publicitar productos, servicios, redes sociales u otras plataformas, salvo que el contexto lo justifique y esté permitido explícitamente. Cualquier publicación con fines comerciales o repetitiva será eliminada sin previo aviso.
                  </li>
                  <li>
                    <span className="font-bold">Mantén el contenido relevante y constructivo.</span><br/>
                    Publica temas y comentarios que aporten valor a la conversación. Evita mensajes vacíos o fuera de lugar. Sé claro, directo y asegúrate de que tu participación contribuya al desarrollo de la comunidad y a resolver dudas o fomentar el debate sano.
                  </li>
                  <li>
                    <span className="font-bold">No compartas información personal.</span><br/>
                    Por seguridad, queda estrictamente prohibido compartir datos personales propios o de terceros como teléfonos, direcciones, correos electrónicos, contraseñas, etc. Protege tu privacidad y la de los demás.
                  </li>
                  <li>
                    <span className="font-bold">Prohibido contenido para adultos o inapropiado.</span><br/>
                    No se permite la publicación de contenido sexual explícito, violento, sensible o que pueda resultar ofensivo para la comunidad. Cualquier mensaje de este tipo será eliminado y el usuario podrá ser sancionado.
                  </li>
                </ol>
                <div className="mt-6 p-4 bg-emerald-50 border-l-4 border-emerald-400 rounded-lg">
                  <span className="block text-emerald-700 font-bold mb-1">🔒 Uso exclusivo del foro para las secciones establecidas:</span>
                  <span className="text-gray-700 text-base">
                    Este foro ha sido diseñado exclusivamente para debatir y compartir en las categorías habilitadas: <span className="font-semibold">Dieta, Recetas, Entrenamiento y General</span>. El uso del foro debe ceñirse a estas temáticas. Si un mensaje no encaja claramente en ninguna de estas secciones, se considerará fuera de lugar y podrá ser eliminado por los moderadores.
                  </span>
                </div>
                <p className="mt-6 text-emerald-900 text-base md:text-lg font-semibold">
                  Cumplir con estas reglas nos permite mantener un entorno seguro, útil y agradable para todos. ¡Gracias por ser parte de esta comunidad!
                </p>
              </div>
            </div>
          </>
        )}

        {vista === 'temas' && (
          <>
            {/* Formulario para crear tema */}
            {mostrarFormulario && (
              <CrearTemaForm onClose={() => setMostrarFormulario(false)} onSubmit={handleCrearTema} categorias={categoriasValidas} />
            )}
            {/* Temas */}
            {temasFiltrados.length === 0 ? (
              <p className="text-gray-500 text-center mt-20">No hay temas disponibles por ahora.</p>
            ) : (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {temasFiltrados.map((tema) => (
                  <Link
                    key={tema.id}
                    to={`/foro/temas/${tema.id}`}
                    className="bg-white border border-gray-200 rounded-lg shadow-md hover:shadow-lg p-6 transition-shadow block"
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
                  </Link>
                ))}
              </div>
            )}
          </>
        )}
      </div>
    </div>
  );
}