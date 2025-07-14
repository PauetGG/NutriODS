import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import type { Articulo } from "../types/Articulo";

export default function ArticulosPage() {
  const [articulos, setArticulos] = useState<Articulo[]>([]);
  const [busqueda, setBusqueda] = useState("");
  const [categoriaFiltro, setCategoriaFiltro] = useState("");
  const [paginaActual, setPaginaActual] = useState(1);
  const articulosPorPagina = 6;
  const navigate = useNavigate();

  useEffect(() => {
    fetch("http://localhost:8080/api/articulos")
      .then((res) => res.json())
      .then((data) => {
        const visibles = data.filter((art: Articulo) => art.visible);
        setArticulos(visibles);
      })
      .catch((err) => console.error("Error al cargar artículos:", err));
  }, []);

  const categoriasUnicas = [...new Set(articulos.map((item) => item.categoria))];

  const articulosFiltrados = articulos.filter((item) => {
    const coincideBusqueda = item.titulo.toLowerCase().includes(busqueda.toLowerCase());
    const coincideCategoria = categoriaFiltro === "" || item.categoria === categoriaFiltro;
    return coincideBusqueda && coincideCategoria;
  });

  const totalPaginas = Math.ceil(articulosFiltrados.length / articulosPorPagina);
  const indiceInicio = (paginaActual - 1) * articulosPorPagina;
  const articulosPagina = articulosFiltrados.slice(indiceInicio, indiceInicio + articulosPorPagina);

  const cambiarPagina = (num: number) => {
    setPaginaActual(num);
    window.scrollTo({ top: 0, behavior: "smooth" });
  };

  return (
    <div className="bg-gray-50 min-h-screen py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-7xl mx-auto">
        <h1 className="text-4xl font-bold text-center text-emerald-700 mb-10">
          Artículos Educativos
        </h1>

        {/* Filtros */}
        <div className="flex flex-wrap justify-center gap-4 mb-10">
          <input
            type="text"
            placeholder="Buscar por título..."
            value={busqueda}
            onChange={(e) => {
              setBusqueda(e.target.value);
              setPaginaActual(1);
            }}
            className="w-full sm:w-64 px-4 py-2 rounded-lg border border-gray-300 shadow-sm focus:outline-none focus:ring-2 focus:ring-emerald-400"
          />

          <select
            value={categoriaFiltro}
            onChange={(e) => {
              setCategoriaFiltro(e.target.value);
              setPaginaActual(1);
            }}
            className="w-full sm:w-52 px-4 py-2 rounded-lg border border-gray-300 shadow-sm bg-white focus:outline-none focus:ring-2 focus:ring-emerald-400"
          >
            <option value="">Todas las categorías</option>
            {categoriasUnicas.map((cat) => (
              <option key={cat} value={cat}>
                {cat.charAt(0).toUpperCase() + cat.slice(1)}
              </option>
            ))}
          </select>

          <button
            onClick={() => {
              setBusqueda("");
              setCategoriaFiltro("");
              setPaginaActual(1);
            }}
            className="px-4 py-2 bg-red-100 text-red-700 rounded-lg hover:bg-red-200 transition"
          >
            Limpiar
          </button>
        </div>

        {/* Artículos */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
          {articulosPagina.map((articulo) => (
            <div
              key={articulo.id}
              onClick={() => navigate(`/articulo/${articulo.id}`)}
              className="bg-white shadow-md hover:shadow-lg rounded-xl overflow-hidden cursor-pointer transition duration-300"
            >
              <img
                src={articulo.imagenUrl}
                alt={articulo.titulo}
                className="w-full h-48 object-cover"
              />
              <div className="p-5">
                <h2 className="text-lg font-semibold text-gray-800 mb-1">{articulo.titulo}</h2>
                <p className="text-sm text-gray-600 mb-2 line-clamp-3">{articulo.resumen}</p>
                <p className="text-xs text-gray-500 mb-2">
                  {new Date(articulo.fechaPublicacion).toLocaleDateString("es-ES")} · {articulo.autor}
                </p>
                <span className="inline-block bg-emerald-100 text-emerald-700 text-xs px-3 py-1 rounded-full">
                  {articulo.categoria}
                </span>
              </div>
            </div>
          ))}
        </div>

        {/* Paginación */}
        {totalPaginas > 1 && (
          <div className="flex justify-center mt-10 space-x-2">
            {Array.from({ length: totalPaginas }, (_, i) => i + 1).map((num) => (
              <button
                key={num}
                onClick={() => cambiarPagina(num)}
                className={`px-4 py-2 rounded-lg border text-sm ${
                  num === paginaActual
                    ? "bg-emerald-600 text-white font-semibold shadow"
                    : "bg-white hover:bg-gray-100 text-gray-700 border-gray-300"
                }`}
              >
                {num}
              </button>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
