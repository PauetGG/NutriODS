import { useEffect, useState } from "react";
import type { Receta } from "../types/Receta";

export default function RecetasPage() {
  const [recetas, setRecetas] = useState<Receta[]>([]);
  const [busqueda, setBusqueda] = useState("");
  const [paginaActual, setPaginaActual] = useState(1);
  const [recetaSeleccionada, setRecetaSeleccionada] = useState<Receta | null>(null);

  const recetasPorPagina = 9;

  useEffect(() => {
    fetch("http://localhost:8080/api/recetas")
      .then((res) => res.json())
      .then((data) => {
        setRecetas(Array.isArray(data) ? data : (Array.isArray(data.content) ? data.content : []));
      })
      .catch(console.error);
  }, []);

  const recetasFiltradas = recetas.filter((r) =>
    r.nombre.toLowerCase().includes(busqueda.toLowerCase())
  );

  const totalPaginas = Math.ceil(recetasFiltradas.length / recetasPorPagina);
  const indiceInicio = (paginaActual - 1) * recetasPorPagina;
  const recetasPagina = recetasFiltradas.slice(indiceInicio, indiceInicio + recetasPorPagina);

  const cambiarPagina = (num: number) => {
    setPaginaActual(num);
    window.scrollTo({ top: 0, behavior: "smooth" });
  };

  return (
    <div className="p-6 min-h-screen bg-gray-100">
      {/* Solo margen extra arriba para bajar el título */}
      <h1 className="text-3xl font-bold mb-6 mt-10 text-center text-green-700">Recetas</h1>

      <input
        type="text"
        placeholder="Buscar receta..."
        value={busqueda}
        onChange={(e) => {
          setBusqueda(e.target.value);
          setPaginaActual(1);
        }}
        className="border p-2 mb-6 w-full max-w-md mx-auto block rounded"
      />

      {recetasPagina.length === 0 ? (
        <p className="text-center text-gray-600 mt-10">
          No hay recetas para mostrar 😕
        </p>
      ) : (
        <>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            {recetasPagina.map((receta) => (
              <div
                key={receta.id}
                onClick={() => setRecetaSeleccionada(receta)}
                className="bg-white p-4 rounded-xl shadow hover:shadow-lg transition cursor-pointer flex flex-col items-center"
              >
                <img
                  src={receta.imagenUrl || "https://via.placeholder.com/300"}
                  alt={receta.nombre}
                  className="w-full h-40 object-cover rounded-lg mb-4"
                />
                <h2 className="text-xl font-semibold text-center text-gray-800">{receta.nombre}</h2>
              </div>
            ))}
          </div>

          {totalPaginas > 1 && (
            <div className="flex justify-center mt-8 gap-3 flex-wrap">
              {Array.from({ length: totalPaginas }, (_, i) => i + 1).map((num) => (
                <button
                  key={num}
                  onClick={() => cambiarPagina(num)}
                  className={`px-4 py-2 rounded border transition ${
                    num === paginaActual
                      ? "bg-green-700 text-white font-bold"
                      : "hover:bg-green-200"
                  }`}
                >
                  {num}
                </button>
              ))}
            </div>
          )}
        </>
      )}

      {recetaSeleccionada && (
        <div
          className="fixed inset-0 bg-black bg-opacity-60 flex justify-center items-center z-50"
          onClick={() => setRecetaSeleccionada(null)}
        >
          <div
            className="bg-white rounded-lg p-6 max-w-lg w-full max-h-[90vh] overflow-y-auto relative"
            onClick={(e) => e.stopPropagation()}
          >
            <button
              onClick={() => setRecetaSeleccionada(null)}
              className="absolute top-4 right-4 text-2xl font-bold text-gray-600 hover:text-gray-900"
              aria-label="Cerrar"
            >
              ×
            </button>

            <h2 className="text-2xl font-bold mb-4 text-center">{recetaSeleccionada.nombre}</h2>
            <img
              src={recetaSeleccionada.imagenUrl || "https://via.placeholder.com/300"}
              alt={recetaSeleccionada.nombre}
              className="w-full h-48 object-cover rounded mb-4"
            />
            <p className="mb-4">{recetaSeleccionada.descripcion}</p>
            <p className="text-sm text-gray-600 mb-2">
              Tiempo: {recetaSeleccionada.tiempoPreparacion} min | Dificultad:{" "}
              {recetaSeleccionada.dificultad} | Raciones: {recetaSeleccionada.raciones}
            </p>
            <h3 className="font-semibold mb-2">Instrucciones:</h3>
            <p className="whitespace-pre-wrap">{recetaSeleccionada.instrucciones || "Sin instrucciones."}</p>
          </div>
        </div>
      )}
    </div>
  );
}
