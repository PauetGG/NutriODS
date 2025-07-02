import { useEffect, useState } from "react";
import Modal from "react-modal";

type GlosarioItem = {
  id: number;
  termino: string;
  definicion: string;
  fuente: string;
  categoria: string;
  imagenUrl: string;
  visible: boolean;
};

Modal.setAppElement("#root");

export default function GlosarioPage() {
  const [glosario, setGlosario] = useState<GlosarioItem[]>([]);
  const [modalOpen, setModalOpen] = useState(false);
  const [itemSeleccionado, setItemSeleccionado] = useState<GlosarioItem | null>(null);
  const [busqueda, setBusqueda] = useState("");
  const [categoriaSeleccionada, setCategoriaSeleccionada] = useState("");

  const [paginaActual, setPaginaActual] = useState(1);
  const itemsPorPagina = 9;

  const categorias = [
    "concepto",
    "macronutriente",
    "micronutriente",
    "vitamina",
    "mineral",
    "suplemento",
    "dieta",
    "deporte",
    "otro",
  ];

  useEffect(() => {
    aplicarFiltros("", "");
  }, []);

  const aplicarFiltros = async (termino: string, categoria: string) => {
    try {
      const query = new URLSearchParams();
      if (termino.trim()) query.append("termino", termino);
      if (categoria) query.append("categoria", categoria);

      const res = await fetch(`http://localhost:8080/api/glosario/filtrado?${query.toString()}`);
      const data = await res.json();
      setGlosario(Array.isArray(data) ? data : []);
      setPaginaActual(1); // reiniciar a la primera página
    } catch (err) {
      console.error("Error al aplicar filtros:", err);
      setGlosario([]);
    }
  };

  const handleBusqueda = (e: React.ChangeEvent<HTMLInputElement>) => {
    const valor = e.target.value;
    setBusqueda(valor);
    aplicarFiltros(valor, categoriaSeleccionada);
  };

  const handleCategoria = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const valor = e.target.value;
    setCategoriaSeleccionada(valor);
    aplicarFiltros(busqueda, valor);
  };

  const abrirModal = (item: GlosarioItem) => {
    setItemSeleccionado(item);
    setModalOpen(true);
  };

  const cerrarModal = () => {
    setModalOpen(false);
    setItemSeleccionado(null);
  };

  const indiceInicio = (paginaActual - 1) * itemsPorPagina;
  const indiceFin = indiceInicio + itemsPorPagina;
  const glosarioPaginado = glosario.slice(indiceInicio, indiceFin);
  const totalPaginas = Math.ceil(glosario.length / itemsPorPagina);

  return (
    <div className="p-6 pt-20 bg-gray-100 min-h-screen">
      <h1 className="text-3xl font-bold mb-6 text-center text-green-700">Glosario Nutricional</h1>

      {/* Buscador y filtro */}
      <div className="flex flex-col md:flex-row justify-center gap-4 mb-6 flex-wrap">
      <input
        type="text"
        placeholder="Buscar término..."
        value={busqueda}
        onChange={handleBusqueda}
        className="p-2 border rounded w-full md:w-1/3"
      />

      <select
        value={categoriaSeleccionada}
        onChange={handleCategoria}
        className="p-2 border rounded w-full md:w-1/4"
      >
        <option value="">Todas las categorías</option>
        {categorias.map((cat) => (
          <option key={cat} value={cat}>
            {cat.charAt(0).toUpperCase() + cat.slice(1)}
          </option>
        ))}
      </select>

      <button
        onClick={() => {
          setBusqueda("");
          setCategoriaSeleccionada("");
          aplicarFiltros("", "");
        }}
        className="p-2 bg-red-100 text-red-700 rounded hover:bg-red-200 transition cursor-pointer"
      >
        X
      </button>
    </div>

      {/* Lista de tarjetas */}
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
        {glosarioPaginado.map((item) => (
          <div
            key={item.id}
            onClick={() => abrirModal(item)}
            className="cursor-pointer bg-white rounded-xl shadow-md hover:shadow-lg transition p-4"
          >
            <img
              src={item.imagenUrl}
              alt={item.termino}
              className="w-full h-40 object-cover rounded-lg mb-4"
            />
            <h2 className="text-xl font-semibold text-green-800">{item.termino}</h2>
            <p className="text-sm text-gray-600 mt-1">Categoría: {item.categoria}</p>
          </div>
        ))}
      </div>

      {/* Paginación */}
    {totalPaginas > 1 && (
    <div className="flex justify-center mt-8 gap-2 flex-wrap items-center">
        <button
        onClick={() => setPaginaActual((prev) => Math.max(prev - 1, 1))}
        disabled={paginaActual === 1}
        className={`px-3 py-1 rounded ${
            paginaActual === 1 ? "bg-gray-300 text-gray-500 cursor-not-allowed" : "bg-white border"
        }`}
        >
        ← Anterior
        </button>

        {(() => {
        const paginas = [];
        const rango = 1;
        const inicio = Math.max(2, paginaActual - rango);
        const fin = Math.min(totalPaginas - 1, paginaActual + rango);

        paginas.push(
            <button
            key={1}
            onClick={() => setPaginaActual(1)}
            className={`px-3 py-1 rounded ${paginaActual === 1 ? "bg-green-600 text-white" : "bg-white border"}`}
            >
            1
            </button>
        );

        if (inicio > 2) {
            paginas.push(<span key="start-ellipsis">…</span>);
        }

        for (let i = inicio; i <= fin; i++) {
            paginas.push(
            <button
                key={i}
                onClick={() => setPaginaActual(i)}
                className={`px-3 py-1 rounded ${paginaActual === i ? "bg-green-600 text-white" : "bg-white border"}`}
            >
                {i}
            </button>
            );
        }

        if (fin < totalPaginas - 1) {
            paginas.push(<span key="end-ellipsis">…</span>);
        }

        if (totalPaginas > 1) {
            paginas.push(
            <button
                key={totalPaginas}
                onClick={() => setPaginaActual(totalPaginas)}
                className={`px-3 py-1 rounded ${
                paginaActual === totalPaginas ? "bg-green-600 text-white" : "bg-white border"
                }`}
            >
                {totalPaginas}
            </button>
            );
        }

        return paginas;
        })()}

        <button
        onClick={() => setPaginaActual((prev) => Math.min(prev + 1, totalPaginas))}
        disabled={paginaActual === totalPaginas}
        className={`px-3 py-1 rounded ${
            paginaActual === totalPaginas
            ? "bg-gray-300 text-gray-500 cursor-not-allowed"
            : "bg-white border"
        }`}
        >
        Siguiente →
        </button>
    </div>
    )}

      {/* Modal detalle */}
      <Modal
        isOpen={modalOpen}
        onRequestClose={cerrarModal}
        contentLabel="Detalle del término"
        className="max-w-xl mx-auto mt-20 bg-white p-6 rounded-xl shadow-xl relative"
        overlayClassName="fixed inset-0 backdrop-blur-sm bg-opacity-50 flex justify-center items-start z-50"
      >
        {itemSeleccionado && (
          <div>
            <button
              onClick={cerrarModal}
              className="absolute top-2 right-3 text-red-600 text-lg font-bold"
            >
              ✕
            </button>
            <img
              src={itemSeleccionado.imagenUrl}
              alt={itemSeleccionado.termino}
              className="w-full h-52 object-cover rounded-lg mb-4"
            />
            <h2 className="text-2xl font-bold mb-2 text-green-700">{itemSeleccionado.termino}</h2>
            <p className="mb-2 text-gray-700">{itemSeleccionado.definicion}</p>
            <p className="text-sm text-gray-600">Fuente: {itemSeleccionado.fuente}</p>
            <p className="text-sm text-gray-600">Categoría: {itemSeleccionado.categoria}</p>
          </div>
        )}
      </Modal>
    </div>
  );
}
