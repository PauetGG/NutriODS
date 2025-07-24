import { useEffect, useState } from "react";
import { Select, Button } from '@mantine/core';
import { IconSearch, IconCategory, IconCheck, IconChevronDown, IconBook, IconApple, IconVaccine, IconRun, IconQuestionMark, IconVideo, IconWorld } from '@tabler/icons-react';
import { Combobox, Transition } from '@headlessui/react';
import { Fragment, useState as useStateReact } from 'react';
import RadialCategoryMenu from '../components/RadialCategoryMenu';

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

  // Para autocompletado
  const [query, setQuery] = useStateReact("");
  const multimediaFiltradaAutocomplete =
    query === ""
      ? multimedia
      : multimedia.filter((item) =>
          item.titulo.toLowerCase().includes(query.toLowerCase())
        );

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

  // Iconos para cada categoría (puedes personalizar según tus categorías)
  const categoryIcons: Record<string, React.ReactNode> = {
    video: <IconBook />,
    web: <IconApple />,
    otro: <IconQuestionMark />,
  };
  const radialCategories = categoriasUnicas.map(cat => ({
    value: cat,
    label: cat.charAt(0).toUpperCase() + cat.slice(1),
    icon: categoryIcons[cat] || <IconCategory />,
  }));

  return (
    <div className="p-6 pt-10 min-h-screen bg-gray-100">
      <h1 className="text-4xl font-bold text-center text-emerald-700 mb-8">Recursos Educativos</h1>

      {/* Filtros tipo recetas */}
      <div className="w-full flex flex-wrap justify-center items-end gap-3 md:gap-6 mb-10">
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
                placeholder="Buscar por título..."
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
                  {multimediaFiltradaAutocomplete.length === 0 && query !== "" ? (
                    <div className="relative cursor-default select-none px-4 py-2 text-gray-700">
                      No se encontró ningún recurso.
                    </div>
                  ) :
                    multimediaFiltradaAutocomplete.slice(0, 8).map((item) => (
                      <Combobox.Option
                        key={item.id}
                        className={({ active }) =>
                          `relative cursor-pointer select-none py-2 pl-8 pr-4 rounded-lg flex items-center gap-2.5 ${
                            active ? "bg-emerald-50 text-emerald-900" : "text-gray-900"}
                          `}
                        value={item.titulo}
                      >
                        {({ selected }) => (
                          <>
                            <IconSearch className="w-4 h-4 text-emerald-400" />
                            <span className={`block truncate ${selected ? "font-semibold" : "font-normal"}`}>{item.titulo}</span>
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
        {/* Botones de tipo (video/web) */}
        <div className="flex flex-row items-end gap-3">
          <div className="flex gap-3">
            <Button
              leftSection={<IconVideo size={22} />}
              size="lg"
              radius="xl"
              variant={tipoFiltro === 'video' ? 'filled' : 'outline'}
              color={tipoFiltro === 'video' ? 'red' : 'gray'}
              onClick={() => {
                setTipoFiltro(tipoFiltro === 'video' ? '' : 'video');
                setPaginaActual(1);
              }}
              style={{
                fontWeight: 700,
                fontSize: 18,
                minWidth: 110,
                boxShadow: tipoFiltro === 'video' ? '0 0 16px 0 #fca5a5bb, 0 2px 12px #f87171' : undefined,
                filter: tipoFiltro === 'video' ? 'brightness(1.08) drop-shadow(0 0 8px #fca5a5)' : undefined,
                transition: 'box-shadow 0.2s, filter 0.2s',
              }}
            >
              Video
            </Button>
            <Button
              leftSection={<IconWorld size={22} />}
              size="lg"
              radius="xl"
              variant={tipoFiltro === 'web' ? 'filled' : 'outline'}
              color={tipoFiltro === 'web' ? 'cyan' : 'gray'}
              onClick={() => {
                setTipoFiltro(tipoFiltro === 'web' ? '' : 'web');
                setPaginaActual(1);
              }}
              style={{
                fontWeight: 700,
                fontSize: 18,
                minWidth: 110,
                boxShadow: tipoFiltro === 'web' ? '0 0 16px 0 #22d3ee88, 0 2px 12px #06b6d4' : undefined,
                filter: tipoFiltro === 'web' ? 'brightness(1.08) drop-shadow(0 0 8px #67e8f9)' : undefined,
                transition: 'box-shadow 0.2s, filter 0.2s',
              }}
            >
              Web
            </Button>
          </div>
          <div className="flex items-center justify-center">
            <RadialCategoryMenu
              categories={radialCategories}
              value={categoriaFiltro}
              onSelect={cat => {
                setCategoriaFiltro(cat);
                setPaginaActual(1);
              }}
            />
            {categoriaFiltro && (
              <button
                className="ml-2 text-xs text-red-600 underline"
                onClick={() => {
                  setCategoriaFiltro("");
                  setPaginaActual(1);
                }}
              >
                Limpiar categoría
              </button>
            )}
          </div>
        </div>
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
