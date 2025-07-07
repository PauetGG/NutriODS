import { useCallback, useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import Modal from "react-modal";
import { Sidebar } from '../components/SideBar'
import { Calendar } from '../components/Calendar'

type Seguimiento = {
  id: number;
  diaSemana: string;
  comida: string;
  porciones: number;
  consumido: boolean;
  notas: string;
  fecha: string;
  comidaModelo: {
    nombre: string;
    caloriasTotales: number;
  };
};

Modal.setAppElement("#root");

function SeguimientoPage() {
  const { dietaId } = useParams<{ dietaId: string }>();
  const dietaIdNumber = Number(dietaId);

  const [seguimiento, setSeguimiento] = useState<Seguimiento[]>([]);
  const [semanaActual, setSemanaActual] = useState(1);
  const [modalOpen, setModalOpen] = useState(false);
  const [comidaSeleccionada, setComidaSeleccionada] = useState<Seguimiento | null>(null);
  const [modoVista, setModoVista] = useState<"diaria" | "semanal" | "mensual">("semanal");
  const [fechaInicioDieta, setFechaInicioDieta] = useState<Date | null>(null);
  const [fechaDiaActual, setFechaDiaActual] = useState(new Date());
  const [mesActual, setMesActual] = useState(new Date().getMonth());
  const [anioActual, setAnioActual] = useState(new Date().getFullYear());

  const fetchSeguimiento = useCallback(async () => {
      if (!dietaId || isNaN(dietaIdNumber)) return;
      try {
        const [resSeguimiento, resDieta] = await Promise.all([
          fetch(`http://localhost:8080/api/seguimiento-dieta/dieta/${dietaIdNumber}`),
          fetch(`http://localhost:8080/api/dietas/${dietaIdNumber}`)
        ]);

        const dataSeguimiento = await resSeguimiento.json();
        const dataDieta = await resDieta.json();

        setSeguimiento(dataSeguimiento);
        setFechaInicioDieta(new Date(dataDieta.created));
      } catch (err) {
        console.error("Error cargando seguimiento o dieta:", err);
      }
    }, [dietaId, dietaIdNumber]);

    useEffect(() => {
      fetchSeguimiento();
    }, [fetchSeguimiento]);

    const handleDayClick = (comida: Seguimiento) => {
      setComidaSeleccionada(comida);
      setModalOpen(true);
    };

    const generarMesSiNecesario = useCallback(async (anio: number, mes: number) => {
      try {
        await fetch(`http://localhost:8080/api/seguimiento-dieta/generar-mes-completo/${dietaIdNumber}?anio=${anio}&mes=${mes + 1}`, {
          method: "POST",
        });
        fetchSeguimiento();
      } catch (err) {
        console.error("Error generando el mes:", err);
      }
    }, [dietaIdNumber, fetchSeguimiento]);

  useEffect(() => {
  if (modoVista === "mensual") {
    generarMesSiNecesario(anioActual, mesActual);
  }
}, [modoVista, mesActual, anioActual, generarMesSiNecesario]);

  // Comidas para la vista diaria (fechaDiaActual)
  const seguimientoHoy = seguimiento.filter((s) => {
    const fecha = new Date(s.fecha).toISOString().split("T")[0];
    const actual = fechaDiaActual.toISOString().split("T")[0];
    return fecha === actual;
  });

  // Comidas para la vista mensual (mesActual, anioActual)
  const seguimientoMes = seguimiento.filter((s) => {
    const fecha = new Date(s.fecha);
    return (
      fecha.getMonth() === mesActual &&
      fecha.getFullYear() === anioActual
    );
  });

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

  const diasSemana = ["lunes", "martes", "miércoles", "jueves", "viernes", "sábado", "domingo"];
  const ordenComidas = ["desayuno", "almuerzo", "comida", "merienda", "cena"];

  const seguimientoSemana = seguimiento.filter((s) => {
    const fecha = new Date(s.fecha);
    const semana = Math.floor((fecha.getDate() - 1) / 7) + 1;
    return semana === semanaActual;
  });

  const seguimientoPorDia: { [key: string]: Seguimiento[] } = {};
  diasSemana.forEach((dia) => {
    seguimientoPorDia[dia] = seguimientoSemana.filter((s) => s.diaSemana.toLowerCase() === dia);
  });

  // Obtener rango de fechas de la semana actual
  const fechaInicioSemana = fechaInicioDieta
    ? new Date(fechaInicioDieta.getFullYear(), fechaInicioDieta.getMonth(), fechaInicioDieta.getDate() + (semanaActual - 1) * 7)
    : new Date();

  const fechaFinSemana = fechaInicioSemana
    ? new Date(fechaInicioSemana.getFullYear(), fechaInicioSemana.getMonth(), fechaInicioSemana.getDate() + 6)
    : new Date();

  const formatearFecha = (fecha: Date | null) =>
    fecha ? fecha.toLocaleDateString("es-ES", { day: "2-digit", month: "short" }) : "";

  return (
  <div className="flex min-h-screen bg-gray-50">
    {/* Sidebar */}
    <Sidebar />

    {/* Contenido principal */}
    <main className="flex-1 p-8">
      {/* Puedes poner aquí un título si lo deseas */}
      <h1 className="text-2xl font-bold mb-6">Seguimiento</h1>

      {/* Calendar */}
      <div className="mb-10">
        <Calendar />
      </div>

      {/* Tu contenido personalizado */}
      <div className="p-4 max-w-7xl mx-auto mt-10">
        {/* Encabezado de navegación */}
        <div className="relative mb-6 overflow-hidden max-w-full">
          <div className="flex items-center justify-between">
            {/* ... aquí va TODO el código que me pasaste ... */}
            {/* Puedes pegar aquí tu bloque de navegación, flechas, botones de vista, etc. */}
          </div>
        </div>

        {/* Vista diaria */}
        {modoVista === "diaria" && (
          <div className="space-y-3">
            {seguimientoHoy.map((c) => (
              <div
                key={c.id}
                className="border rounded p-3 shadow-sm bg-gray-50 cursor-pointer"
                onClick={() => handleDayClick(c)}
              >
                <p className="font-semibold capitalize">{c.comida}</p>
                <p>{c.comidaModelo.nombre}</p>
                <p>{c.consumido ? "✅ Consumido" : "❌ No consumido"}</p>
              </div>
            ))}
          </div>
        )}

        {/* Vista semanal */}
        {modoVista === "semanal" && (
          <div className="overflow-x-auto">
            <table className="table-auto border border-gray-300 w-full text-center">
              <thead>
                <tr>
                  <th className="bg-gray-100 p-2 border border-gray-300">Comida</th>
                  {diasSemana.map((dia) => (
                    <th
                      key={dia}
                      className="bg-gray-100 p-2 border border-gray-300 uppercase"
                    >
                      {dia}
                    </th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {ordenComidas.map((tipo) => (
                  <tr key={tipo}>
                    <td className="p-2 font-semibold border border-gray-300 text-left capitalize bg-gray-50">
                      {tipo}
                    </td>
                    {diasSemana.map((dia) => {
                      const comida = seguimientoPorDia[dia]?.find(
                        (c) => c.comida.toLowerCase() === tipo
                      );
                      return (
                        <td
                          key={dia + tipo}
                          className={`p-2 text-sm border border-gray-300 cursor-pointer min-h-[60px] rounded ${
                            comida?.consumido ? "bg-green-100" : "bg-gray-100"
                          }`}
                          onClick={() => comida && handleDayClick(comida)}
                        >
                          {comida?.comidaModelo?.nombre || "-"}
                        </td>
                      );
                    })}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}

        {/* Vista mensual */}
        {modoVista === "mensual" && (
          <div className="grid grid-cols-7 gap-2">
            {Array.from({
              length: new Date(
                new Date().getFullYear(),
                new Date().getMonth() + 1,
                0
              ).getDate(),
            }).map((_, i) => {
              const fechaActual = new Date(
                new Date().getFullYear(),
                new Date().getMonth(),
                i + 1
              )
                .toISOString()
                .split("T")[0];
              const comidasDelDia = seguimientoMes.filter(
                (s) => s.fecha === fechaActual
              );
              return (
                <div
                  key={i}
                  className="border p-2 rounded text-sm bg-gray-50 shadow-sm"
                >
                  <div className="font-bold mb-1">Día {i + 1}</div>
                  {comidasDelDia.length === 0 ? (
                    <p className="text-gray-400">Sin comidas</p>
                  ) : (
                    comidasDelDia.map((c) => (
                      <div
                        key={c.id}
                        className="mb-1 cursor-pointer"
                        onClick={() => handleDayClick(c)}
                      >
                        <p className="capitalize">
                          {c.comida}: <strong>{c.comidaModelo.nombre}</strong>
                        </p>
                        <p className="text-xs">{c.consumido ? "✅" : "❌"}</p>
                      </div>
                    ))
                  )}
                </div>
              );
            })}
          </div>
        )}

        {/* Modal de edición */}
        {comidaSeleccionada && (
          <Modal
            isOpen={modalOpen}
            onRequestClose={() => setModalOpen(false)}
            className="bg-white p-6 rounded-md max-w-md mx-auto mt-20 shadow-lg z-500"
            overlayClassName="fixed inset-0 backdrop-blur-sm bg-opacity-40 flex items-center justify-center"
          >
            <h2 className="text-xl font-bold mb-2 capitalize">
              {comidaSeleccionada.comida}
            </h2>
            <p className="text-gray-700 mb-3">
              <strong>Comida:</strong> {comidaSeleccionada.comidaModelo.nombre}
            </p>

            <label className="flex items-center mb-3 gap-2">
              <input
                type="checkbox"
                checked={comidaSeleccionada.consumido}
                onChange={(e) =>
                  setComidaSeleccionada({
                    ...comidaSeleccionada,
                    consumido: e.target.checked,
                  })
                }
              />
              ¿Has consumido esta comida?
            </label>

            <textarea
              className="w-full border rounded p-2 mb-4 text-sm"
              rows={3}
              placeholder="Notas..."
              value={comidaSeleccionada.notas || ""}
              onChange={(e) =>
                setComidaSeleccionada({
                  ...comidaSeleccionada,
                  notas: e.target.value,
                })
              }
            />

            <div className="flex justify-end gap-2">
              <button
                className="px-4 py-2 bg-gray-300 rounded"
                onClick={() => setModalOpen(false)}
              >
                Cancelar
              </button>
              <button
                className="px-4 py-2 bg-green-600 text-white rounded"
                onClick={guardarCambio}
              >
                Guardar
              </button>
            </div>
          </Modal>
        )}
      </div>
    </main>
  </div>
)
}

export default SeguimientoPage;
