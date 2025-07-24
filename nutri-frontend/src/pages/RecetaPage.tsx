import { useEffect, useState, Fragment } from "react";
import type { Receta } from "../types/Receta";
import ReactPaginate from "react-paginate";
import { Popover, Transition, Combobox } from "@headlessui/react";
import { ClockIcon, CheckIcon, ChevronUpDownIcon, FireIcon, SparklesIcon, FaceSmileIcon, LightBulbIcon } from "@heroicons/react/24/solid";
import { MagnifyingGlassIcon } from "@heroicons/react/24/outline";
import { Modal, Group, Badge, List, ThemeIcon, Loader, Paper, ScrollArea } from '@mantine/core';
import { IconListCheck, IconClock, IconUsers, IconChefHat } from '@tabler/icons-react';

export default function RecetasPage() {
  const [allRecetas, setAllRecetas] = useState<Receta[]>([]);
  const [filteredRecetas, setFilteredRecetas] = useState<Receta[]>([]);
  const [busqueda, setBusqueda] = useState("");
  const [dificultad, setDificultad] = useState<string>("todas");
  const [tiempoKey, setTiempoKey] = useState<string>("all");
  const [isTiempoOpen, setIsTiempoOpen] = useState(false);
  const [paginaActual, setPaginaActual] = useState(1);
  const [recetaSeleccionada, setRecetaSeleccionada] = useState<Receta | null>(null);
  const [query, setQuery] = useState("");
  const [ingredientesReceta, setIngredientesReceta] = useState<any[] | null>(null);
  const [loadingIngredientes, setLoadingIngredientes] = useState(false);

  const dificultades = [
    { label: "Todas", value: "todas", icon: SparklesIcon, color: "bg-gradient-to-r from-emerald-400 to-emerald-600" },
    { label: "Fácil", value: "fácil", icon: FaceSmileIcon, color: "bg-emerald-200" },
    { label: "Media", value: "media", icon: LightBulbIcon, color: "bg-yellow-200" },
    { label: "Difícil", value: "difícil", icon: FireIcon, color: "bg-red-200" },
  ];

  const tiempos = [
    { key: "all", label: "Cualquiera", min: 0, max: Infinity, icon: SparklesIcon },
    { key: "0-10", label: "0-10 min", min: 0, max: 10, icon: ClockIcon },
    { key: "10-20", label: "10-20 min", min: 11, max: 20, icon: ClockIcon },
    { key: "20-30", label: "20-30 min", min: 21, max: 30, icon: ClockIcon },
    { key: "30-40", label: "30-40 min", min: 31, max: 40, icon: ClockIcon },
    { key: "40-50", label: "40-50 min", min: 41, max: 50, icon: ClockIcon },
    { key: "50-60", label: "50-60 min", min: 51, max: 60, icon: ClockIcon },
    { key: "60+", label: "60+ min", min: 61, max: Infinity, icon: ClockIcon },
  ];

  const recetasPorPagina = 9;

  useEffect(() => {
    fetch("http://localhost:8080/api/recetas/visible")
      .then((res) => (res.ok ? res.json() : []))
      .then((data) => {
        setAllRecetas(Array.isArray(data) ? data : []);
        setFilteredRecetas(Array.isArray(data) ? data : []);
      })
      .catch(console.error);
  }, []);

  // Autocomplete para búsqueda
  const recetasFiltradasAutocomplete =
    query === ""
      ? allRecetas
      : allRecetas.filter((receta) =>
          receta.nombre.toLowerCase().includes(query.toLowerCase())
        );

  useEffect(() => {
    let result = allRecetas;
    if (busqueda.trim()) {
      result = result.filter((receta) =>
        receta.nombre.toLowerCase().includes(busqueda.trim().toLowerCase())
      );
    }
    if (dificultad !== "todas") {
      result = result.filter((receta) => receta.dificultad === dificultad);
    }
    if (tiempoKey !== "all") {
      const rango = tiempos.find((t) => t.key === tiempoKey);
      if (rango) {
        result = result.filter(
          (receta) =>
            receta.tiempoPreparacion >= rango.min &&
            receta.tiempoPreparacion <= rango.max
        );
      }
    }
    setFilteredRecetas(result);
    setPaginaActual(1);
  }, [busqueda, dificultad, tiempoKey, allRecetas]);

  const totalPaginas = Math.ceil(filteredRecetas.length / recetasPorPagina);
  const indiceInicio = (paginaActual - 1) * recetasPorPagina;
  const recetasPagina = filteredRecetas.slice(
    indiceInicio,
    indiceInicio + recetasPorPagina
  );

  const cambiarPagina = (num: number) => {
    setPaginaActual(num);
    window.scrollTo({ top: 0, behavior: "smooth" });
  };

  // Nuevo: fetch ingredientes al seleccionar receta
  const handleSeleccionarReceta = async (receta: Receta) => {
    setRecetaSeleccionada(receta);
    setLoadingIngredientes(true);
    setIngredientesReceta(null);
    try {
      const res = await fetch(`http://localhost:8080/api/receta-ingredientes/receta/${receta.id}`);
      if (res.ok) {
        const data = await res.json();
        setIngredientesReceta(data);
      } else {
        setIngredientesReceta([]);
      }
    } catch {
      setIngredientesReceta([]);
    }
    setLoadingIngredientes(false);
  };

  return (
    <div className="p-6 pt-10 min-h-screen bg-gray-100">
      <h1 className="text-4xl font-bold text-center text-emerald-700 mb-8">
        Encuentra tu Receta Perfecta
      </h1>
      <div className="flex flex-col gap-8 justify-center items-center mb-10 p-8 bg-gray-100 rounded-2xl shadow-lg">
        {/* Filtros en línea: buscador, dificultad, tiempo */}
        <div className="w-full flex flex-wrap justify-center items-end gap-3 md:gap-6">
          {/* Buscador grande a la izquierda */}
          <div className="w-72">
            <Combobox value={busqueda} onChange={v => setBusqueda(v ?? "")}> {/* <-- wrapper para evitar null */}
              <div className="relative w-full">
                <span className="absolute inset-y-0 left-0 flex items-center pl-4">
                  <MagnifyingGlassIcon className="h-5 w-5 text-emerald-400" />
                </span>
                <Combobox.Input
                  className="pl-12 pr-10 py-3 border border-gray-200 rounded-full shadow focus:shadow-lg w-full text-lg bg-white focus:outline-none focus:ring-2 focus:ring-emerald-400 transition placeholder-gray-400"
                  displayValue={(receta: string) => receta}
                  onChange={(event) => {
                    setQuery(event.target.value);
                    setBusqueda(event.target.value);
                  }}
                  placeholder="Buscar..."
                />
                <Combobox.Button className="absolute inset-y-0 right-0 flex items-center pr-3">
                  <ChevronUpDownIcon className="h-5 w-5 text-gray-300" aria-hidden="true" />
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
                    {recetasFiltradasAutocomplete.length === 0 && query !== "" ? (
                      <div className="relative cursor-default select-none px-4 py-2 text-gray-700">
                        No se encontró ninguna receta.
                      </div>
                    ) : (
                      recetasFiltradasAutocomplete.slice(0, 8).map((receta) => (
                        <Combobox.Option
                          key={receta.id}
                          className={({ active }) =>
                            `relative cursor-pointer select-none py-2 pl-8 pr-4 rounded-lg flex items-center gap-2.5 ${
                              active ? "bg-emerald-50 text-emerald-900" : "text-gray-900"
                            }`
                          }
                          value={receta.nombre}
                        >
                          {({ selected, active }) => (
                            <>
                              <SparklesIcon className="w-4 h-4 text-emerald-400" />
                              <span
                                className={`block truncate ${selected ? "font-semibold" : "font-normal"}`}
                              >
                                {receta.nombre}
                              </span>
                              {selected ? (
                                <span className="absolute inset-y-0 left-0 flex items-center pl-2 text-emerald-600">
                                  <CheckIcon className="h-4 w-4" aria-hidden="true" />
                                </span>
                              ) : null}
                            </>
                          )}
                        </Combobox.Option>
                      ))
                    )}
                  </Combobox.Options>
                </Transition>
              </div>
            </Combobox>
          </div>
          {/* Dificultad en línea con título arriba */}
          <div className="flex flex-col items-center">
            <span className="text-sm font-medium text-gray-700 mb-1">Dificultad</span>
            <div className="flex flex-wrap justify-center gap-3">
              {dificultades.map(({ label, value, icon: Icon, color }) => (
                <button
                  key={value}
                  onClick={() => setDificultad(value)}
                  className={`px-7 py-3 text-lg font-semibold rounded-full transition-all duration-300 flex items-center gap-3 border-2 shadow-sm hover:shadow-md hover:-translate-y-1 ${
                    dificultad === value
                      ? `${color} text-emerald-900 border-emerald-700 shadow-lg scale-105`
                      : "bg-white text-gray-800 border-gray-200"
                  }`}
                >
                  <Icon className="w-6 h-6" />
                  <span>{label}</span>
                </button>
              ))}
            </div>
          </div>
          {/* Filtro Tiempo (reloj) con título arriba */}
          <div className="flex flex-col items-center">
            <span className="text-sm font-medium text-gray-700 mb-1">Tiempo de Preparación</span>
            <Popover as="div" className="relative">
              {({ open }) => (
                <>
                  <Popover.Button
                    onClick={() => setIsTiempoOpen(!isTiempoOpen)}
                    className={`p-4 rounded-full transition-all duration-300 flex items-center justify-center border-2 shadow-md hover:shadow-lg hover:-translate-y-1 bg-white border-gray-200 ${
                      tiempoKey !== "all" ? "border-emerald-400" : ""
                    } ${open ? "ring-2 ring-emerald-400" : ""}`}
                  >
                    <span className="relative flex items-center justify-center">
                      <ClockIcon
                        className={`w-7 h-7 text-emerald-500 transition-transform duration-300 ${
                          open ? "animate-pulse scale-110" : ""
                        }`}
                      />
                      {tiempoKey !== "all" && (
                        <span className="absolute -bottom-2 left-1/2 -translate-x-1/2 text-xs bg-emerald-100 text-emerald-700 px-2 py-0.5 rounded-full shadow border border-emerald-200 animate-fade-in">
                          {tiempos.find((t) => t.key === tiempoKey)?.label}
                        </span>
                      )}
                    </span>
                  </Popover.Button>
                  <Transition
                    as={Fragment}
                    enter="transition ease-out duration-200"
                    enterFrom="opacity-0 translate-y-2"
                    enterTo="opacity-100 translate-y-0"
                    leave="transition ease-in duration-150"
                    leaveFrom="opacity-100 translate-y-0"
                    leaveTo="opacity-0 translate-y-2"
                  >
                    <Popover.Panel className="absolute z-10 mt-3 w-48 bg-white rounded-xl shadow-xl border p-2 left-1/2 -translate-x-1/2">
                      <div className="flex flex-col gap-1">
                        {tiempos.map(({ key, label, icon: Icon }) => (
                          <button
                            key={key}
                            onClick={() => {
                              setTiempoKey(key);
                              setIsTiempoOpen(false);
                            }}
                            className={`w-full flex items-center gap-2 px-4 py-2 text-base rounded-md transition-colors ${
                              tiempoKey === key
                                ? "bg-emerald-600 text-white font-semibold"
                                : "text-gray-700 hover:bg-emerald-50"
                            }`}
                          >
                            <Icon className="w-5 h-5" />
                            {label}
                          </button>
                        ))}
                      </div>
                    </Popover.Panel>
                  </Transition>
                </>
              )}
            </Popover>
          </div>
        </div>
      </div>
      {recetasPagina.length === 0 ? (
        <p className="text-center text-gray-600 mt-10">
          No hay recetas para mostrar con los filtros seleccionados 😕
        </p>
      ) : (
        <>
          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
            {recetasPagina.map((receta) => (
              <div
                key={receta.id}
                onClick={() => handleSeleccionarReceta(receta)}
                className="bg-white rounded-xl shadow-md hover:shadow-lg cursor-pointer transition p-4 flex flex-col items-center"
              >
                <img
                  src={receta.imagenUrl || "https://via.placeholder.com/300"}
                  alt={receta.nombre}
                  className="w-full h-40 object-cover rounded-lg mb-4"
                />
                <h2 className="text-xl font-semibold text-emerald-700 text-center">{receta.nombre}</h2>
                <p className="text-sm text-gray-600 mt-1">Dificultad: {receta.dificultad} | Tiempo: {receta.tiempoPreparacion} min</p>
              </div>
            ))}
          </div>
          <ReactPaginate
            pageCount={totalPaginas}
            onPageChange={(e) => cambiarPagina(e.selected + 1)}
            containerClassName="flex justify-center items-center mt-10 gap-2 flex-wrap"
            pageLinkClassName="px-3 py-1 rounded-lg border bg-white text-gray-700 hover:bg-gray-100 transition-all duration-200"
            activeLinkClassName="bg-emerald-600 text-white font-semibold shadow-lg scale-110"
            previousLabel={<span className="inline-block"><svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M15 19l-7-7 7-7" /></svg></span>}
            nextLabel={<span className="inline-block"><svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 5l7 7-7 7" /></svg></span>}
            previousLinkClassName="px-3 py-1 rounded-lg border bg-white text-gray-700 hover:bg-gray-100"
            nextLinkClassName="px-3 py-1 rounded-lg border bg-white text-gray-700 hover:bg-gray-100"
            breakLabel={'...'}
            breakLinkClassName="px-3 py-1 rounded-lg border bg-white text-gray-700"
            disabledClassName="opacity-50 cursor-not-allowed"
          />
        </>
      )}
      {recetaSeleccionada && (
        <Modal
          opened={!!recetaSeleccionada}
          onClose={() => setRecetaSeleccionada(null)}
          size="auto"
          centered
          padding={0}
          withCloseButton={false}
          overlayProps={{ blur: 3, backgroundOpacity: 0.3 }}
          styles={{ body: { padding: 0 } }}
        >
          <Paper radius="xl" shadow="xl" p={0} style={{ overflow: 'hidden', minHeight: '80vh', minWidth: '80vw', maxWidth: '98vw', maxHeight: '98vh', display: 'flex', flexDirection: 'row' }}>
            {/* IZQUIERDA: Imagen grande */}
            <div style={{ flex: 1.2, background: 'linear-gradient(180deg,#d1fae5 0%,#fff 100%)', display: 'flex', alignItems: 'center', justifyContent: 'center', padding: 0, minWidth: 0 }}>
              <img
                src={recetaSeleccionada.imagenUrl || 'https://via.placeholder.com/700x900'}
                alt={recetaSeleccionada.nombre}
                style={{ width: '100%', height: 'auto', maxHeight: '90vh', objectFit: 'cover', borderRadius: 0, boxShadow: '0 8px 32px #0001' }}
              />
            </div>
            {/* DERECHA: Info principal */}
            <div style={{ flex: 1.8, display: 'flex', flexDirection: 'column', padding: 48, position: 'relative', minWidth: 0, height: '100%' }}>
              <button
                onClick={() => setRecetaSeleccionada(null)}
                style={{ position: 'absolute', top: 24, right: 24, background: 'none', border: 'none', cursor: 'pointer', zIndex: 2 }}
                aria-label="Cerrar"
              >
                <svg width={32} height={32} fill="none" stroke="#64748b" strokeWidth={2.5} strokeLinecap="round" strokeLinejoin="round"><path d="M6 6l20 20M6 26L26 6" /></svg>
              </button>
              {/* Nombre y descripción */}
              <div style={{ marginBottom: 18 }}>
                <h2 style={{ fontSize: 40, fontWeight: 900, color: '#047857', marginBottom: 10, textAlign: 'left', lineHeight: 1.1 }}>{recetaSeleccionada.nombre}</h2>
                <div style={{ color: '#374151', fontSize: 20, marginBottom: 8, textAlign: 'left', whiteSpace: 'pre-line' }}>{recetaSeleccionada.descripcion}</div>
              </div>
              {/* Instrucciones y ingredientes+badges en grid */}
              <div style={{ display: 'flex', flexDirection: 'row', gap: 40, flex: 1, minHeight: 0 }}>
                {/* Instrucciones */}
                <div style={{ flex: 2, minWidth: 0, display: 'flex', flexDirection: 'column' }}>
                  <h3 style={{ fontSize: 24, fontWeight: 700, color: '#334155', marginBottom: 10, display: 'flex', alignItems: 'center', gap: 8 }}><IconChefHat size={24} /> Instrucciones</h3>
                  <ScrollArea h={340} offsetScrollbars>
                    <div style={{ color: '#374151', fontSize: 17, whiteSpace: 'pre-line', marginBottom: 12 }}>{recetaSeleccionada.instrucciones || 'No se han proporcionado instrucciones.'}</div>
                  </ScrollArea>
                </div>
                {/* Ingredientes y badges */}
                <div style={{ flex: 1.2, minWidth: 0, display: 'flex', flexDirection: 'column', gap: 24, alignItems: 'flex-start', justifyContent: 'flex-start' }}>
                  <div>
                    <h4 style={{ fontSize: 20, fontWeight: 700, color: '#334155', marginBottom: 10, display: 'flex', alignItems: 'center', gap: 8 }}><IconListCheck size={22} /> Ingredientes</h4>
                    {loadingIngredientes ? (
                      <Loader size="sm" color="teal" />
                    ) : ingredientesReceta && ingredientesReceta.length > 0 ? (
                      <List
                        spacing="xs"
                        size="md"
                        icon={<ThemeIcon color="teal" size={24} radius="xl"><IconListCheck size={16} /></ThemeIcon>}
                        style={{ color: '#334155', fontSize: 17 }}
                      >
                        {ingredientesReceta.map((ing: any) => (
                          <List.Item key={ing.ingrediente?.id || ing.id}>
                            {ing.ingrediente?.nombre || 'Ingrediente'}
                            {ing.cantidad ? ` – ${ing.cantidad}${ing.unidad ? ' ' + ing.unidad : ''}` : ''}
                          </List.Item>
                        ))}
                      </List>
                    ) : (
                      <div style={{ color: '#64748b', fontSize: 15 }}>No hay ingredientes para esta receta.</div>
                    )}
                  </div>
                  <div style={{ display: 'flex', flexDirection: 'column', gap: 16, marginTop: 16 }}>
                    <Badge color="teal" size="lg" leftSection={<IconClock size={20} />}>{recetaSeleccionada.tiempoPreparacion} min</Badge>
                    <Badge color="yellow" size="lg" leftSection={<IconUsers size={20} />}>{recetaSeleccionada.raciones} raciones</Badge>
                    <Badge
                      color={recetaSeleccionada.dificultad === 'fácil' ? 'teal' : recetaSeleccionada.dificultad === 'media' ? 'yellow' : 'red'}
                      size="lg"
                      leftSection={<IconChefHat size={20} />}
                    >
                      {recetaSeleccionada.dificultad.charAt(0).toUpperCase() + recetaSeleccionada.dificultad.slice(1)}
                    </Badge>
                  </div>
                </div>
              </div>
            </div>
          </Paper>
        </Modal>
      )}
    </div>
  );
}
