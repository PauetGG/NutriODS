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
    "concepto", "macronutriente", "micronutriente", "vitamina", "mineral",
    "suplemento", "dieta", "deporte", "otro"
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
      setPaginaActual(1);
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
  const glosarioPaginado = glosario.slice(indiceInicio, indiceInicio + itemsPorPagina);
  const totalPaginas = Math.ceil(glosario.length / itemsPorPagina);

  return (
    <div className="p-6 pt-10 min-h-screen bg-gray-100">
      <h1 className="text-4xl font-bold text-center text-emerald-700 mb-8">Glosario Nutricional</h1>

      {/* Filtros */}
      <div className="flex flex-wrap gap-4 justify-center items-center mb-8">
        <input
          type="text"
          placeholder="Buscar término..."
          value={busqueda}
          onChange={handleBusqueda}
          className="px-4 py-2 border border-gray-300 rounded-lg shadow-sm w-full md:w-1/3 focus:outline-none focus:ring-2 focus:ring-emerald-400"
        />
        <select
          value={categoriaSeleccionada}
          onChange={handleCategoria}
          className="px-4 py-2 border border-gray-300 rounded-lg shadow-sm w-full md:w-1/4 focus:outline-none focus:ring-2 focus:ring-emerald-400"
        >
          <option value="">Todas las categorías</option>
          {categorias.map((cat) => (
            <option key={cat} value={cat}>{cat.charAt(0).toUpperCase() + cat.slice(1)}</option>
          ))}
        </select>
        <button
          onClick={() => {
            setBusqueda("");
            setCategoriaSeleccionada("");
            aplicarFiltros("", "");
          }}
          className="px-4 py-2 bg-red-100 text-red-700 rounded-lg hover:bg-red-200 transition"
        >
          Limpiar filtros
        </button>
      </div>

      {/* Tarjetas del glosario */}
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
        {glosarioPaginado.map((item) => (
          <div
            key={item.id}
            onClick={() => abrirModal(item)}
            className="bg-white rounded-xl shadow-md hover:shadow-lg cursor-pointer transition p-4"
          >
            <img
              src={item.imagenUrl}
              alt={item.termino}
              className="w-full h-40 object-contain rounded-lg mb-4"
            />
            <h2 className="text-xl font-semibold text-emerald-700">{item.termino}</h2>
            <p className="text-sm text-gray-600 mt-1">Categoría: {item.categoria}</p>
          </div>
        ))}
      </div>

      {/* Paginación */}
      {totalPaginas > 1 && (
        <div className="flex justify-center items-center mt-10 gap-2 flex-wrap">
          {[...Array(totalPaginas)].map((_, i) => (
            <button
              key={i}
              onClick={() => setPaginaActual(i + 1)}
              className={`px-3 py-1 rounded-lg border ${
                paginaActual === i + 1
                  ? "bg-emerald-600 text-white font-semibold"
                  : "bg-white text-gray-700 hover:bg-gray-100"
              }`}
            >
              {i + 1}
            </button>
          ))}
        </div>
      )}

      {/* Modal de detalle */}
      <Modal
        isOpen={modalOpen}
        onRequestClose={cerrarModal}
        contentLabel="Detalle del término"
        className="max-w-xl mx-auto mt-20 bg-white p-6 rounded-xl shadow-xl relative"
        overlayClassName="fixed inset-0 backdrop-blur-sm bg-black/20 flex justify-center items-start z-50"
      >
        {itemSeleccionado && (
          <div>
            <button
              onClick={cerrarModal}
              className="absolute top-2 right-3 text-red-600 text-xl font-bold"
            >
              ✕
            </button>
            <img
              src={itemSeleccionado.imagenUrl}
              alt={itemSeleccionado.termino}
              className="w-full h-52 object-contain rounded-lg mb-4"
            />
            <h2 className="text-2xl font-bold mb-2 text-emerald-700">{itemSeleccionado.termino}</h2>
            <p className="text-gray-700 mb-4">{itemSeleccionado.definicion}</p>
            <p className="text-sm text-gray-600 mb-1">Fuente: {itemSeleccionado.fuente}</p>
            <p className="text-sm text-gray-600">Categoría: {itemSeleccionado.categoria}</p>
          </div>
        )}
      </Modal>
    </div>
  );
}
