import { useEffect, useState, Fragment } from "react";
import { useNavigate } from "react-router-dom";
import type { Articulo } from "../types/Articulo";
import { Combobox, Transition } from '@headlessui/react';
import { IconSearch, IconCategory, IconCheck, IconChevronDown, IconBook, IconApple, IconVaccine, IconRun, IconQuestionMark } from '@tabler/icons-react';
import RadialCategoryMenu from '../components/RadialCategoryMenu';

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

  // Para autocompletado
  const [query, setQuery] = useState("");
  const articulosFiltradosAutocomplete =
    query === ""
      ? articulos
      : articulos.filter((item) =>
          item.titulo.toLowerCase().includes(query.toLowerCase())
        );

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

  // Iconos para cada categoría (puedes personalizar según tus categorías)
  const categoryIcons: Record<string, React.ReactNode> = {
    nutricion: <IconApple />,
    salud: <IconVaccine />,
    deporte: <IconRun />,
    recetas: <IconBook />,
    otro: <IconQuestionMark />,
  };
  const radialCategories = categoriasUnicas.map(cat => ({
    value: cat,
    label: cat.charAt(0).toUpperCase() + cat.slice(1),
    icon: categoryIcons[cat] || <IconCategory />,
  }));

  return (
    <div className="bg-gray-50 min-h-screen pt-10 px-4 sm:px-6 lg:px-8">
      <div className="max-w-7xl mx-auto">
        <h1 className="text-4xl font-bold text-center text-emerald-700 mb-10">
          Artículos Educativos
        </h1>

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
                    {articulosFiltradosAutocomplete.length === 0 && query !== "" ? (
                      <div className="relative cursor-default select-none px-4 py-2 text-gray-700">
                        No se encontró ningún artículo.
                      </div>
                    ) :
                      articulosFiltradosAutocomplete.slice(0, 8).map((item) => (
                        <Combobox.Option
                          key={item.id}
                          className={({ active }) =>
                            `relative cursor-pointer select-none py-2 pl-8 pr-4 rounded-lg flex items-center gap-2.5 ${
                              active ? "bg-emerald-50 text-emerald-900" : "text-gray-900"
                            }`
                          }
                          value={item.titulo}
                        >
                          {({ selected, active }) => (
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
          {/* Menú radial de categorías */}
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
                className="w-full h-48 object-contain"
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
