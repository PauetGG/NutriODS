import { useParams } from "react-router-dom";
import { useSeguimientoDieta, type Seguimiento } from "../hooks/useSeguimientoDieta";
import { ChevronLeftIcon, ChevronRightIcon, ChevronDownIcon } from "lucide-react";
import { useState } from "react";
import { ModalComida } from "../components/ModalComida";

export const Calendar = () => {
  const [modoVista, setModoVista] = useState<"monthly" | "weekly" | "daily">("monthly");
  const [fechaActual, setFechaActual] = useState(new Date());
  const [modalOpen, setModalOpen] = useState(false);
  const [comidaSeleccionada, setComidaSeleccionada] = useState<Seguimiento | null>(null);
  const { dietaId } = useParams<{ dietaId: string }>();
  const dietaIdNumber = Number(dietaId);
  const { seguimiento, setSeguimiento } = useSeguimientoDieta(dietaIdNumber);

  const capitalizar = (texto: string) => texto.charAt(0).toUpperCase() + texto.slice(1);

  const guardarCambio = async () => {
    if (!comidaSeleccionada) return;
    try {
      const res = await fetch(`http://localhost:8080/api/seguimiento-dieta/${comidaSeleccionada.id}`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(comidaSeleccionada),
      });
      if (!res.ok) throw new Error("Error al guardar");
      setSeguimiento((prev) =>
        prev.map((s) => (s.id === comidaSeleccionada.id ? comidaSeleccionada : s))
      );
      setModalOpen(false);
    } catch (err) {
      alert("Error al guardar");
      console.error(err);
    }
  };

  const formatearCabecera = (fecha: Date) => {
    if (modoVista === "monthly") {
      const mes = capitalizar(fecha.toLocaleDateString("es-ES", { month: "long" }));
      const año = fecha.getFullYear();
      return `${mes} del ${año}`;
    } else if (modoVista === "weekly") {
      const inicio = new Date(fecha);
      inicio.setDate(fecha.getDate() - ((fecha.getDay() + 6) % 7));
      const fin = new Date(inicio);
      fin.setDate(inicio.getDate() + 6);
      const diaInicio = inicio.getDate();
      const diaFin = fin.getDate();
      const mesInicio = capitalizar(inicio.toLocaleDateString("es-ES", { month: "long" }));
      const mesFin = capitalizar(fin.toLocaleDateString("es-ES", { month: "long" }));
      const año = inicio.getFullYear();
      if (mesInicio === mesFin) {
        return `Semana ${diaInicio} - ${diaFin} de ${mesInicio} del ${año}`;
      } else {
        return `Semana ${diaInicio} de ${mesInicio} - ${diaFin} de ${mesFin} del ${año}`;
      }
    } else {
      return capitalizar(fecha.toLocaleDateString("es-ES", {
        weekday: "long", day: "numeric", month: "long", year: "numeric"
      }));
    }
  };

  const comidasPorFecha: Record<string, Seguimiento[]> = {};
  seguimiento.forEach((s) => {
    const fecha = s.fecha.split("T")[0];
    if (!comidasPorFecha[fecha]) comidasPorFecha[fecha] = [];
    comidasPorFecha[fecha].push(s);
  });

  const abrirModal = (comida: Seguimiento) => {
    setComidaSeleccionada(comida);
    setModalOpen(true);
  };

  const generarContenido = (fecha: Date) => {
    const key = fecha.toISOString().split("T")[0];
    const comidas = comidasPorFecha[key] || [];

    if (modoVista === "monthly") {
      return comidas.map((c, i) => (
        <div
          key={i}
          className="text-xs text-gray-700 cursor-pointer hover:bg-green-100 p-1 rounded transition"
          onClick={() => abrirModal(c)}
        >
          {c.comida}
        </div>
      ));
    } else if (modoVista === "weekly") {
      const tiposOrden = ["desayuno", "comida", "merienda", "cena"];
      const comidasOrdenadas = [...comidas].sort(
        (a, b) => tiposOrden.indexOf(a.comida) - tiposOrden.indexOf(b.comida)
      );

      const grupos = tiposOrden.map((tipo) => ({
        tipo,
        comidas: comidasOrdenadas.filter((c) => c.comida === tipo)
      }));

      return (
        <div className="flex flex-col gap-2">
          {grupos.map((grupo, i) => (
            <div key={i}>
              {grupo.comidas.length > 0 && (
                <div className="text-xs font-semibold text-gray-500 capitalize mb-1">{grupo.tipo}</div>
              )}
              {grupo.comidas.map((c, j) => (
                <div
                  key={j}
                  onClick={() => abrirModal(c)}
                  className="text-sm text-gray-700 cursor-pointer hover:bg-green-100 px-1 py-1 rounded transition"
                >
                  {c.comidaModelo.nombre}
                </div>
              ))}
            </div>
          ))}
        </div>
      );
    } else {
      return (
        <div className="space-y-3 mt-3 max-w-3xl mx-auto px-4">
          {comidas.map((c, i) => (
            <div
              key={i}
              className="p-4 bg-gray-50 rounded-lg shadow border text-sm cursor-pointer hover:bg-gray-100 transition"
              onClick={() => abrirModal(c)}
            >
              <div className="text-base font-semibold text-gray-700 uppercase">{c.comida}</div>
              <div className="text-sm text-gray-800">{c.comidaModelo.nombre}</div>
              <div className="text-xs text-gray-500 mt-1">Calorías: {c.comidaModelo.caloriasTotales}</div>
              {c.notas && <div className="text-xs italic text-gray-400 mt-1">Notas: {c.notas}</div>}
              <div className="mt-1 text-xs text-gray-400">
                Estado: {c.consumido ? "✔ Consumido" : "✘ Pendiente"}
              </div>
            </div>
          ))}
        </div>
      );
    }
  };

  const generarDias = () => {
    const dias = [];
    const año = fechaActual.getFullYear();
    const mes = fechaActual.getMonth();
    const primerDia = new Date(año, mes, 1);
    const diaInicio = (primerDia.getDay() + 6) % 7;
    const totalCeldas = 35;

    if (modoVista === "monthly") {
      for (let i = 0; i < totalCeldas; i++) {
        const fecha = new Date(año, mes, i - diaInicio + 1);
        dias.push(fecha);
      }
    } else if (modoVista === "weekly") {
      const inicio = new Date(fechaActual);
      inicio.setDate(inicio.getDate() - ((inicio.getDay() + 6) % 7));
      for (let i = 0; i < 7; i++) {
        const fecha = new Date(inicio);
        fecha.setDate(inicio.getDate() + i);
        dias.push(fecha);
      }
    } else {
      dias.push(fechaActual);
    }

    return dias;
  };

  const irAtras = () => {
    const nueva = new Date(fechaActual);
    if (modoVista === "monthly") nueva.setMonth(nueva.getMonth() - 1);
    else if (modoVista === "weekly") nueva.setDate(nueva.getDate() - 7);
    else nueva.setDate(nueva.getDate() - 1);
    setFechaActual(nueva);
  };

  const irAdelante = () => {
    const nueva = new Date(fechaActual);
    if (modoVista === "monthly") nueva.setMonth(nueva.getMonth() + 1);
    else if (modoVista === "weekly") nueva.setDate(nueva.getDate() + 7);
    else nueva.setDate(nueva.getDate() + 1);
    setFechaActual(nueva);
  };

  const dias = generarDias();

  return (
    <div className="bg-white rounded-lg shadow">
      {/* Cabecera */}
      <div className="p-4 flex items-center justify-between border-b border-gray-200">
        <div className="flex items-center">
          <button onClick={irAtras} className="p-1 hover:bg-gray-100 rounded-md">
            <ChevronLeftIcon size={20} />
          </button>
          <h2 className="mx-4 font-medium capitalize text-lg">{formatearCabecera(fechaActual)}</h2>
          <button onClick={irAdelante} className="p-1 hover:bg-gray-100 rounded-md">
            <ChevronRightIcon size={20} />
          </button>
        </div>
        <div className="relative">
          <select
            className="appearance-none bg-white border border-gray-200 rounded-md px-3 py-1 pr-8 text-sm"
            value={modoVista}
            onChange={(e) => setModoVista(e.target.value as "monthly" | "weekly" | "daily")}
          >
            <option value="monthly">Mensual</option>
            <option value="weekly">Semanal</option>
            <option value="daily">Diaria</option>
          </select>
          <ChevronDownIcon size={16} className="absolute right-2 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none" />
        </div>
      </div>

      {(modoVista === "weekly" || modoVista === "monthly") && (
        <div className="grid grid-cols-7 border-b border-gray-200">
          {["Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"].map((dia) => (
            <div
              key={dia}
              className="p-3 text-center text-sm font-medium text-gray-600 border-r border-gray-200 last:border-r-0"
            >
              {dia}
            </div>
          ))}
        </div>
      )}

      <div className={`grid ${modoVista === "monthly" ? "grid-cols-7 grid-rows-5" : modoVista === "weekly" ? "grid-cols-7" : "grid-cols-1"}`}>
        {dias.map((fecha, index) => (
          <div
            key={index}
            className={`min-h-[100px] p-2 border-r border-b border-gray-200 last:border-r-0 ${
              fecha.getDay() === 0 || fecha.getDay() === 6 ? "bg-gray-50" : ""
            }`}
          >
            {modoVista !== "daily" && (
              <div className="text-sm font-medium text-gray-600 mb-1">{fecha.getDate()}</div>
            )}
            {generarContenido(fecha)}
          </div>
        ))}
      </div>

      {comidaSeleccionada && (
        <ModalComida
          comida={comidaSeleccionada}
          setComida={setComidaSeleccionada}
          isOpen={modalOpen}
          onClose={() => setModalOpen(false)}
          onGuardar={guardarCambio}
        />
      )}
    </div>
  );
};
