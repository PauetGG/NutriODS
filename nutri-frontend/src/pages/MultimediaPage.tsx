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
    const coincideBusqueda = item.titulo
      .toLowerCase()
      .includes(busqueda.toLowerCase());
    const coincideTipo = tipoFiltro === "" || item.tipo === tipoFiltro;
    const coincideCategoria =
      categoriaFiltro === "" || item.categoria === categoriaFiltro;
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
    <div className="p-6 pt-15 bg-gray-100 min-h-screen">
      <h1 className="text-3xl font-bold mb-6 text-center text-green-700">
        Recursos Educativos
      </h1>

      {/* Buscador y filtros */}
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
            value={tipoFiltro}
            onChange={(e) => {
            setTipoFiltro(e.target.value);
            setPaginaActual(1);
            }}
            className="p-2 border rounded w-full md:w-1/4"
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
            setTipoFiltro("");
            setCategoriaFiltro("");
            setPaginaActual(1);
            }}
            className="p-2 bg-red-100 text-red-700 rounded hover:bg-red-200 transition cursor-pointer"
        >
            X
        </button>
        </div>

      {/* Lista de recursos */}
     <div className="flex justify-center">
    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        {recursosPagina.map((item) => (
        <a
            key={item.id}
            href={item.url}
            target="_blank"
            rel="noopener noreferrer"
            className="bg-white p-4 rounded-xl shadow hover:shadow-lg transition duration-300 block"
        >
            <div className="flex items-center justify-between mb-2">
            <span className="text-sm text-green-700 font-semibold">
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
