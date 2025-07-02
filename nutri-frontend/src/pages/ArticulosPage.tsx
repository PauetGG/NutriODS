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

  const categoriasUnicas = [
    ...new Set(articulos.map((item) => item.categoria)),
  ];

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
    <div className="p-6 pt-15 bg-gray-100 min-h-screen">
      <h1 className="text-3xl font-bold mb-6 text-center text-green-700">
        Artículos Educativos
      </h1>

      {/* Buscador y filtro */}
      <div className="flex flex-col md:flex-row gap-4 mb-6 justify-center items-center flex-wrap">
      <input
        type="text"
        placeholder="Buscar por título..."
        value={busqueda}
        onChange={(e) => {
          setBusqueda(e.target.value);
          setPaginaActual(1);
        }}
        className="p-2 border rounded w-full md:w-1/3"
      />

      <select
        value={categoriaFiltro}
        onChange={(e) => {
          setCategoriaFiltro(e.target.value);
          setPaginaActual(1);
        }}
        className="p-2 border rounded w-full md:w-1/4"
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
        className="p-2 bg-red-100 text-red-700 rounded hover:bg-red-200 transition cursor-pointer"
      >
        X
      </button>
    </div>

      {/* Lista de artículos */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        {articulosPagina.map((articulo) => (
          <div
            key={articulo.id}
            onClick={() => navigate(`/articulo/${articulo.id}`)}
            className="cursor-pointer bg-white p-4 rounded-xl shadow hover:shadow-lg transition duration-300"
          >
            <img
              src={articulo.imagenUrl}
              alt={articulo.titulo}
              className="w-full h-40 object-cover rounded-lg mb-4"
            />
            <h2 className="text-xl font-semibold text-gray-800 mb-1">{articulo.titulo}</h2>
            <p className="text-sm text-gray-600 mb-2">{articulo.resumen}</p>
            <p className="text-xs text-gray-500 mb-1">
              {new Date(articulo.fechaPublicacion).toLocaleDateString()} · {articulo.autor}
            </p>
            <span className="inline-block bg-green-100 text-green-700 text-xs px-2 py-1 rounded">
              {articulo.categoria}
            </span>
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
              className={`px-3 py-1 border rounded ${
                num === paginaActual
                  ? "bg-green-700 text-white font-bold"
                  : "hover:bg-gray-200"
              }`}
            >
              {num}
            </button>
          ))}
        </div>
      )}
    </div>
  );
}
