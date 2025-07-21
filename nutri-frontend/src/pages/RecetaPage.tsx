import { useEffect, useState } from "react";
import type { Receta } from "../types/Receta";

export default function RecetasPage() {
  const [recetas, setRecetas] = useState<Receta[]>([]);
  const [busqueda, setBusqueda] = useState("");
  const [paginaActual, setPaginaActual] = useState(1);
  const [recetaSeleccionada, setRecetaSeleccionada] = useState<Receta | null>(null);
  const [dificultad, setDificultad] = useState<string>("todas");

  const recetasPorPagina = 9;

  useEffect(() => {
    let url = "";
    if (busqueda.trim() !== "") {
      url = `http://localhost:8080/api/recetas/search?palabra=${encodeURIComponent(busqueda)}`;
      fetch(url)
        .then((res) => res.json())
        .then((data) => {
          // Si dificultad es "todas", muestra todo, si no, filtra por dificultad en frontend
          if (dificultad === "todas") {
            setRecetas(Array.isArray(data) ? data : []);
          } else {
            setRecetas(
              (Array.isArray(data) ? data : []).filter(
                (r) => r.dificultad === dificultad
              )
            );
          }
        })
        .catch(console.error);
    } else {
      url =
        dificultad === "todas"
          ? "http://localhost:8080/api/recetas"
          : `http://localhost:8080/api/recetas/dificultad/${encodeURIComponent(
              dificultad
            )}`;
      fetch(url)
        .then((res) => res.json())
        .then((data) => setRecetas(Array.isArray(data) ? data : []))
        .catch(console.error);
    }
  }, [busqueda, dificultad]);

  const recetasFiltradas = recetas;

  const totalPaginas = Math.ceil(recetasFiltradas.length / recetasPorPagina);
  const indiceInicio = (paginaActual - 1) * recetasPorPagina;
  const recetasPagina = recetasFiltradas.slice(indiceInicio, indiceInicio + recetasPorPagina);

  const cambiarPagina = (num: number) => {
    setPaginaActual(num);
    window.scrollTo({ top: 0, behavior: "smooth" });
  };

  return (
    <div className="p-6 pt-10 min-h-screen bg-gray-100">
      <h1 className="text-4xl font-bold text-center text-emerald-700 mb-8">Recetas</h1>

      {/* Filtros */}
      <div className="flex flex-wrap gap-4 justify-center items-center mb-8">
        <input
          type="text"
          placeholder="Buscar receta..."
          value={busqueda}
          onChange={(e) => {
            setBusqueda(e.target.value);
            setPaginaActual(1);
          }}
          className="px-4 py-2 border border-gray-300 rounded-lg shadow-sm w-full md:w-1/3 focus:outline-none focus:ring-2 focus:ring-emerald-400"
        />
        <select
          value={dificultad}
          onChange={(e) => {
            setDificultad(e.target.value);
            setPaginaActual(1);
          }}
          className="px-4 py-2 border border-gray-300 rounded-lg shadow-sm w-full md:w-1/4 focus:outline-none focus:ring-2 focus:ring-emerald-400"
        >
          <option value="todas">Todas las dificultades</option>
          <option value="fácil">Fácil</option>
          <option value="media">Media</option>
          <option value="difícil">Difícil</option>
        </select>
        <button
          onClick={() => {
            setBusqueda("");
            setDificultad("todas");
            setPaginaActual(1);
          }}
          className="px-4 py-2 bg-red-100 text-red-700 rounded-lg hover:bg-red-200 transition"
        >
          Limpiar filtros
        </button>
      </div>

      {/* Tarjetas de recetas */}
      {recetasPagina.length === 0 ? (
        <p className="text-center text-gray-600 mt-10">
          No hay recetas para mostrar 😕
        </p>
      ) : (
        <>
          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
            {recetasPagina.map((receta) => (
              <div
                key={receta.id}
                onClick={() => setRecetaSeleccionada(receta)}
                className="bg-white rounded-xl shadow-md hover:shadow-lg cursor-pointer transition p-4 flex flex-col items-center"
              >
                <img
                  src={receta.imagenUrl || "https://via.placeholder.com/300"}
                  alt={receta.nombre}
                  className="w-full h-40 object-cover rounded-lg mb-4"
                />
                <h2 className="text-xl font-semibold text-emerald-700 text-center">{receta.nombre}</h2>
                <p className="text-sm text-gray-600 mt-1">Dificultad: {receta.dificultad} | Tiempo: {receta.tiempoPreparacion} min</p>
              </div>
            ))}
          </div>

          {/* Paginación */}
          {totalPaginas > 1 && (
            <div className="flex justify-center items-center mt-10 gap-2 flex-wrap">
              {Array.from({ length: totalPaginas }, (_, i) => i + 1).map((num) => (
                <button
                  key={num}
                  onClick={() => cambiarPagina(num)}
                  className={`px-3 py-1 rounded-lg border ${
                    paginaActual === num
                      ? "bg-emerald-600 text-white font-semibold"
                      : "bg-white text-gray-700 hover:bg-gray-100"
                  }`}
                >
                  {num}
                </button>
              ))}
            </div>
          )}
        </>
      )}

      {/* Modal de detalle de receta */}
      {recetaSeleccionada && (
        <div
          className="fixed inset-0 bg-black bg-opacity-60 flex justify-center items-center z-50"
          onClick={() => setRecetaSeleccionada(null)}
        >
          <div
            className="bg-white rounded-xl p-6 max-w-xl w-full max-h-[90vh] overflow-y-auto relative shadow-xl mt-20"
            onClick={(e) => e.stopPropagation()}
          >
            <button
              onClick={() => setRecetaSeleccionada(null)}
              className="absolute top-2 right-3 text-red-600 text-xl font-bold"
              aria-label="Cerrar"
            >
              ✕
            </button>

            <img
              src={recetaSeleccionada.imagenUrl || "https://via.placeholder.com/300"}
              alt={recetaSeleccionada.nombre}
              className="w-full h-52 object-cover rounded-lg mb-4"
            />
            <h2 className="text-2xl font-bold mb-2 text-emerald-700 text-center">{recetaSeleccionada.nombre}</h2>
            <p className="mb-4 text-gray-700">{recetaSeleccionada.descripcion}</p>
            <p className="text-sm text-gray-600 mb-2">
              Tiempo: {recetaSeleccionada.tiempoPreparacion} min | Dificultad: {recetaSeleccionada.dificultad} | Raciones: {recetaSeleccionada.raciones}
            </p>
            <h3 className="font-semibold mb-2">Instrucciones:</h3>
            <p className="whitespace-pre-wrap text-gray-800">{recetaSeleccionada.instrucciones || "Sin instrucciones."}</p>
          </div>
        </div>
      )}
    </div>
  );
}
