import { useEffect, useState } from "react";
import { Modal, Paper, Badge, ScrollArea } from '@mantine/core';
import { IconBook, IconInfoCircle, IconCategory, IconExternalLink, IconSearch, IconCheck, IconChevronDown, IconApple, IconVaccine, IconRun, IconQuestionMark } from '@tabler/icons-react';
import { Combobox, Transition } from '@headlessui/react';
import { Fragment } from 'react';
import RadialCategoryMenu from '../components/RadialCategoryMenu';

type GlosarioItem = {
  id: number;
  termino: string;
  definicion: string;
  fuente: string;
  categoria: string;
  imagenUrl: string;
  visible: boolean;
};

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

  // Para autocompletado
  const [query, setQuery] = useState("");
  const glosarioFiltradoAutocomplete =
    query === ""
      ? glosario
      : glosario.filter((item) =>
          item.termino.toLowerCase().includes(query.toLowerCase())
        );

  // Emojis únicos para cada categoría
  const categoryEmojis: Record<string, string> = {
    concepto: '💡',
    macronutriente: '🍗',
    micronutriente: '🧬',
    vitamina: '🍊',
    mineral: '🧂',
    suplemento: '💊',
    dieta: '🥗',
    deporte: '🏃‍♂️',
    otro: '❓',
  };
  const radialCategories = categorias.map(cat => ({
    value: cat,
    label: cat.charAt(0).toUpperCase() + cat.slice(1),
    icon: <span className="text-3xl">{categoryEmojis[cat] || '❓'}</span>,
  }));

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

      {/* Filtros tipo recetas */}
      <div className="w-full flex flex-row flex-wrap justify-center items-end gap-3 md:gap-6 mb-8">
        {/* Buscador tipo recetas */}
        <div className="w-72">
          <Combobox value={busqueda} onChange={v => setBusqueda(v ?? "")}> {/* wrapper para evitar null */}
            <div className="relative w-full">
              <span className="absolute inset-y-0 left-0 flex items-center pl-4">
                <IconSearch className="h-5 w-5 text-emerald-400" />
              </span>
              <Combobox.Input
                className="pl-12 pr-10 py-3 border border-gray-200 rounded-full shadow focus:shadow-lg w-full text-lg bg-white focus:outline-none focus:ring-2 focus:ring-emerald-400 transition placeholder-gray-400"
                displayValue={(t: string) => t}
                onChange={event => {
                  setQuery(event.target.value);
                  setBusqueda(event.target.value);
                }}
                placeholder="Buscar término..."
              />
              <Combobox.Button className="absolute inset-y-0 right-0 flex items-center pr-3">
                <IconChevronDown className="h-5 w-5 text-gray-300" aria-hidden="true" />
              </Combobox.Button>
              <Transition
                as={Fragment}
                enter="transition ease-out duration-150"
                enterFrom="opacity-0 -translate-y-2"
                enterTo="opacity-100 translate-y-0"
                leave="transition ease-in duration-100"
                leaveFrom="opacity-100"
                leaveTo="opacity-0"
                afterLeave={() => setQuery("")}
              >
                <Combobox.Options className="absolute z-10 mt-2 max-h-60 w-full overflow-auto rounded-xl bg-white py-1 text-base shadow-2xl ring-1 ring-black/5 focus:outline-none border border-gray-100">
                  {glosarioFiltradoAutocomplete.length === 0 && query !== "" ? (
                    <div className="relative cursor-default select-none px-4 py-2 text-gray-700">
                      No se encontró ningún término.
                    </div>
                  ) :
                    glosarioFiltradoAutocomplete.slice(0, 8).map((item) => (
                      <Combobox.Option
                        key={item.id}
                        className={({ active }) =>
                          `relative cursor-pointer select-none py-2 pl-8 pr-4 rounded-lg flex items-center gap-2.5 ${
                            active ? "bg-emerald-50 text-emerald-900" : "text-gray-900"
                          }`
                        }
                        value={item.termino}
                      >
                        {({ selected, active }) => (
                          <>
                            <IconBook className="w-4 h-4 text-emerald-400" />
                            <span className={`block truncate ${selected ? "font-semibold" : "font-normal"}`}>{item.termino}</span>
                            {selected ? (
                              <span className="absolute inset-y-0 left-0 flex items-center pl-2 text-emerald-600">
                                <IconCheck className="h-4 w-4" aria-hidden="true" />
                              </span>
                            ) : null}
                          </>
                        )}
                      </Combobox.Option>
                    ))
                  }
                </Combobox.Options>
              </Transition>
            </div>
          </Combobox>
        </div>
        {/* Menú radial de categorías */}
        <div className="flex items-center justify-center">
          <RadialCategoryMenu
            categories={radialCategories}
            value={categoriaSeleccionada}
            onSelect={cat => handleCategoria({ target: { value: cat } } as any)}
            selectedLabel={categoriaSeleccionada ? (radialCategories.find(c => c.value === categoriaSeleccionada)?.label || '') : undefined}
            selectedIcon={categoriaSeleccionada ? (categoryEmojis[categoriaSeleccionada] ? <span className="text-5xl">{categoryEmojis[categoriaSeleccionada]}</span> : undefined) : undefined}
          />
          {categoriaSeleccionada && (
            <button
              className="ml-2 text-xs text-red-600 underline"
              onClick={() => handleCategoria({ target: { value: '' } } as any)}
            >
              Limpiar categoría
            </button>
          )}
        </div>
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
        opened={modalOpen}
        onClose={cerrarModal}
        centered
        size="lg"
        withCloseButton={false}
        overlayProps={{ blur: 3, backgroundOpacity: 0.25 }}
        styles={{ body: { padding: 0 } }}
      >
        {itemSeleccionado && (
          <Paper radius="xl" shadow="xl" p={0} style={{ overflow: 'hidden', minWidth: 350, maxWidth: 540 }}>
            <button
              onClick={cerrarModal}
              style={{ position: 'absolute', top: 18, right: 22, background: 'none', border: 'none', cursor: 'pointer', zIndex: 2, fontSize: 28, color: '#e11d48', fontWeight: 900 }}
              aria-label="Cerrar"
            >
              ✕
            </button>
            <div className="flex flex-col items-center p-8 pt-10">
              <img
                src={itemSeleccionado.imagenUrl}
                alt={itemSeleccionado.termino}
                className="w-full h-44 object-contain rounded-lg mb-4"
                style={{ background: '#f0fdfa' }}
              />
              <h2 className="text-2xl font-bold mb-2 text-emerald-700 flex items-center gap-2"><IconBook size={22} />{itemSeleccionado.termino}</h2>
              <Badge color="teal" variant="light" className="mb-2"><IconCategory size={14} style={{ marginRight: 4 }} /> {itemSeleccionado.categoria}</Badge>
              <ScrollArea h={120} offsetScrollbars className="w-full mt-2 mb-2">
                <p className="text-gray-700 text-base mb-2 flex items-start gap-2"><IconInfoCircle size={18} style={{ marginTop: 2 }} />{itemSeleccionado.definicion}</p>
              </ScrollArea>
              <div className="flex flex-row gap-4 items-center mt-2">
                <span className="text-xs text-gray-500 flex items-center gap-1"><IconExternalLink size={14} />Fuente: {itemSeleccionado.fuente}</span>
              </div>
            </div>
          </Paper>
        )}
      </Modal>
    </div>
  );
}
