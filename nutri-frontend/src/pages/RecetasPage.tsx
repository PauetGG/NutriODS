
import { useEffect, useState } from "react";
import type { Receta } from "../types/Receta";

export default function RecetasPage() {
  const [recetas, setRecetas] = useState<Receta[]>([]);
  const [busqueda, setBusqueda] = useState("");
  const [dificultadFiltro, setDificultadFiltro] = useState("");
  const [paginaActual, setPaginaActual] = useState(1);
  const [recetaSeleccionada, setRecetaSeleccionada] = useState<Receta | null>(null);

  const recetasPorPagina = 9;

  useEffect(() => {
    fetch("http://localhost:8080/api/recetas/visible")
      .then((res) => res.json())
      .then((data) => setRecetas(data))
      .catch((err) => console.error("Error al cargar recetas:", err));
  }, []);

  const dificultadesUnicas = [
    ...new Set(recetas.map((item) => item.dificultad)),
  ];

  const recetasFiltradas = recetas.filter((item) => {
    const coincideBusqueda = item.nombre
      .toLowerCase()
      .includes(busqueda.toLowerCase());
    const coincideDificultad =
      dificultadFiltro === "" || item.dificultad === dificultadFiltro;
    return coincideBusqueda && coincideDificultad;
  });

  const totalPaginas = Math.ceil(recetasFiltradas.length / recetasPorPagina);
  const indiceInicio = (paginaActual - 1) * recetasPorPagina;
  const recetasPagina = recetasFiltradas.slice(
    indiceInicio,
    indiceInicio + recetasPorPagina
  );

  const cambiarPagina = (num: number) => {
    setPaginaActual(num);
    window.scrollTo({ top: 0, behavior: "smooth" });
  };

  // Modal close on background click or ESC
  const cerrarModal = () => setRecetaSeleccionada(null);
  
  // ESC key to close modal
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === "Escape") cerrarModal();
    };
    if (recetaSeleccionada) {
      window.addEventListener("keydown", handleKeyDown);
    }
    return () => window.removeEventListener("keydown", handleKeyDown);
  }, [recetaSeleccionada]);

  return (
    <div className="p-6 pt-15 min-h-screen bg-gradient-to-br from-green-50 via-white to-green-100">
      <h1 className="text-3xl font-bold mb-6 text-center text-green-700 drop-shadow">
        Recetas
      </h1>

      {/* Buscador y filtro */}
      <div className="flex flex-col md:flex-row gap-4 mb-6 justify-center items-center flex-wrap">
        <input
          type="text"
          placeholder="Buscar por nombre..."
          value={busqueda}
          onChange={(e) => {
            setBusqueda(e.target.value);
            setPaginaActual(1);
          }}
          className="p-2 border rounded w-full md:w-1/3 shadow-sm focus:ring-2 focus:ring-green-200"
        />

        <select
          value={dificultadFiltro}
          onChange={(e) => {
            setDificultadFiltro(e.target.value);
            setPaginaActual(1);
          }}
          className="p-2 border rounded w-full md:w-1/4 shadow-sm focus:ring-2 focus:ring-green-200"
        >
          <option value="">Todas las dificultades</option>
          {dificultadesUnicas.map((dif) => (
            <option key={dif} value={dif}>
              {dif.charAt(0).toUpperCase() + dif.slice(1)}
            </option>
          ))}
        </select>

        <button
          onClick={() => {
            setBusqueda("");
            setDificultadFiltro("");
            setPaginaActual(1);
          }}
          className="p-2 bg-red-100 text-red-700 rounded hover:bg-red-200 transition cursor-pointer shadow-sm"
        >
          X
        </button>
      </div>

      {/* Lista de recetas */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
        {recetasPagina.map((receta) => (
          <div
            key={receta.id}
            onClick={() => setRecetaSeleccionada(receta)}
            className="bg-white/90 p-4 rounded-2xl shadow-lg hover:shadow-2xl transition duration-300 cursor-pointer border border-green-100 hover:border-green-300 flex flex-col items-center group"
          >
            <img
              src={receta.imagenUrl}
              alt={receta.nombre}
              className="w-full h-44 object-cover rounded-xl mb-4 group-hover:scale-105 transition-transform"
            />
            <h2 className="text-lg font-semibold text-center text-green-800 mb-1 group-hover:underline">
              {receta.nombre}
            </h2>
          </div>
        ))}
      </div>

      {/* Paginación */}
      {totalPaginas > 1 && (
        <div className="flex justify-center flex-wrap mt-8 gap-2">
          {Array.from({ length: totalPaginas }, (_, i) => i + 1).map((num) => (
            <button
              key={num}
              onClick={() => cambiarPagina(num)}
              className={`px-3 py-1 border rounded shadow-sm transition font-medium ${
                num === paginaActual
                  ? "bg-green-700 text-white font-bold border-green-700"
                  : "hover:bg-green-100 border-green-200 text-green-800"
              }`}
            >
              {num}
            </button>
          ))}
        </div>
      )}

      {/* Modal de detalles */}
      {recetaSeleccionada && (
        <div
          className="fixed inset-0 z-40 flex items-center justify-center bg-black/40 backdrop-blur-sm"
          onClick={cerrarModal}
        >
          <div
            className="bg-white rounded-2xl shadow-2xl p-8 max-w-lg w-full relative animate-fadeIn"
            onClick={(e) => e.stopPropagation()}
          >
            <button
              onClick={cerrarModal}
              className="absolute top-3 right-3 text-gray-400 hover:text-red-500 text-2xl font-bold"
              aria-label="Cerrar"
            >
              ×
            </button>
            <img
              src={recetaSeleccionada.imagenUrl}
              alt={recetaSeleccionada.nombre}
              className="w-full h-56 object-cover rounded-xl mb-4"
            />
            <h2 className="text-2xl font-bold text-green-800 mb-2 text-center">
              {recetaSeleccionada.nombre}
            </h2>
            <p className="mb-2 text-gray-700 text-center">
              {recetaSeleccionada.descripcion}
            </p>
            <div className="text-sm text-gray-500 mb-2 text-center">
              {recetaSeleccionada.tiempoPreparacion} min · {recetaSeleccionada.dificultad.charAt(0).toUpperCase() + recetaSeleccionada.dificultad.slice(1)} · {recetaSeleccionada.raciones} raciones
            </div>
            <div className="mt-4">
              <h3 className="font-semibold mb-1 text-green-700">Instrucciones:</h3>
              <pre className="whitespace-pre-wrap text-gray-700 bg-green-50 rounded p-2 text-sm">
                {recetaSeleccionada.instrucciones}
              </pre>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
