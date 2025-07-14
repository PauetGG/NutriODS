import { useEffect, useState } from "react";

type MultimediaItem = {
  id: number;
  titulo: string;
  descripcion: string;
  url: string;
  tipo: "video" | "web";
  categoria: string;
  visible: boolean;
  fechaPublicacion: string;
};

export default function MultimediaPage() {
  const [multimedia, setMultimedia] = useState<MultimediaItem[]>([]);
  const [busqueda, setBusqueda] = useState("");
  const [tipoFiltro, setTipoFiltro] = useState("");
  const [categoriaFiltro, setCategoriaFiltro] = useState("");
  const [paginaActual, setPaginaActual] = useState(1);
  const recursosPorPagina = 9;

  useEffect(() => {
    fetch("http://localhost:8080/api/multimedia")
      .then((res) => res.json())
      .then((data) => setMultimedia(data))
      .catch((err) => console.error("Error al cargar multimedia:", err));
  }, []);

  const categoriasUnicas = [
    ...new Set(multimedia.map((item) => item.categoria)),
  ];

  const multimediaFiltrada = multimedia.filter((item) => {
    const coincideBusqueda = item.titulo.toLowerCase().includes(busqueda.toLowerCase());
    const coincideTipo = tipoFiltro === "" || item.tipo === tipoFiltro;
    const coincideCategoria = categoriaFiltro === "" || item.categoria === categoriaFiltro;
    return item.visible && coincideBusqueda && coincideTipo && coincideCategoria;
  });

  const totalPaginas = Math.ceil(multimediaFiltrada.length / recursosPorPagina);
  const indiceInicio = (paginaActual - 1) * recursosPorPagina;
  const recursosPagina = multimediaFiltrada.slice(indiceInicio, indiceInicio + recursosPorPagina);

  const cambiarPagina = (num: number) => {
    setPaginaActual(num);
    window.scrollTo({ top: 0, behavior: "smooth" });
  };

  return (
    <div className="p-6 pt-24 min-h-screen bg-gray-100">
      <h1 className="text-4xl font-bold text-center text-emerald-700 mb-8">Recursos Educativos</h1>

      {/* Filtros */}
      <div className="flex flex-wrap gap-4 justify-center items-center mb-10">
        <input
          type="text"
          placeholder="Buscar por título..."
          value={busqueda}
          onChange={(e) => {
            setBusqueda(e.target.value);
            setPaginaActual(1);
          }}
          className="px-4 py-2 border border-gray-300 rounded-lg shadow-sm w-full md:w-1/3 focus:outline-none focus:ring-2 focus:ring-emerald-400"
        />

        <select
          value={tipoFiltro}
          onChange={(e) => {
            setTipoFiltro(e.target.value);
            setPaginaActual(1);
          }}
          className="px-4 py-2 border border-gray-300 rounded-lg shadow-sm w-full md:w-1/4 focus:outline-none focus:ring-2 focus:ring-emerald-400"
        >
          <option value="">Todos los tipos</option>
          <option value="video">🎥 Video</option>
          <option value="web">🌐 Web</option>
        </select>

        <select
          value={categoriaFiltro}
          onChange={(e) => {
            setCategoriaFiltro(e.target.value);
            setPaginaActual(1);
          }}
          className="px-4 py-2 border border-gray-300 rounded-lg shadow-sm w-full md:w-1/4 focus:outline-none focus:ring-2 focus:ring-emerald-400"
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
            setTipoFiltro("");
            setCategoriaFiltro("");
            setPaginaActual(1);
          }}
          className="px-4 py-2 bg-red-100 text-red-700 rounded-lg hover:bg-red-200 transition"
        >
          Limpiar filtros
        </button>
      </div>

      {/* Recursos */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        {recursosPagina.map((item) => (
          <a
            key={item.id}
            href={item.url}
            target="_blank"
            rel="noopener noreferrer"
            className="bg-white p-5 rounded-xl shadow-md hover:shadow-lg transition block"
          >
            <div className="flex justify-between items-center mb-2">
              <span className="text-sm text-emerald-700 font-semibold">
                {item.tipo === "video" ? "🎥 Video" : "🌐 Web"}
              </span>
              <span className="text-xs text-gray-500">
                {new Date(item.fechaPublicacion).toLocaleDateString()}
              </span>
            </div>
            <h2 className="text-lg font-bold text-gray-800 mb-1">{item.titulo}</h2>
            <p className="text-sm text-gray-600 mb-2">{item.descripcion}</p>
            <span className="inline-block bg-green-100 text-green-700 text-xs px-2 py-1 rounded">
              {item.categoria}
            </span>
          </a>
        ))}
      </div>

      {/* Paginación */}
      {totalPaginas > 1 && (
        <div className="flex justify-center flex-wrap mt-10 gap-2">
          {Array.from({ length: totalPaginas }, (_, i) => i + 1).map((num) => (
            <button
              key={num}
              onClick={() => cambiarPagina(num)}
              className={`px-3 py-1 rounded-lg border ${
                num === paginaActual
                  ? "bg-emerald-600 text-white font-bold"
                  : "bg-white text-gray-700 hover:bg-gray-200"
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
