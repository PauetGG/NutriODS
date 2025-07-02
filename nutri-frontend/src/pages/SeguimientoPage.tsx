import { useCallback, useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import Modal from "react-modal";
import Swal from 'sweetalert2';


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

  const fetchSeguimiento = useCallback(async () => {
    if (!dietaId || isNaN(dietaIdNumber)) return;

    try {
      const res = await fetch(`http://localhost:8080/api/seguimiento-dieta/dieta/${dietaIdNumber}`);
      const data = await res.json();
      setSeguimiento(data);
    } catch (err) {
      console.error("Error cargando seguimiento:", err);
    }
  }, [dietaId, dietaIdNumber]);

  useEffect(() => {
    fetchSeguimiento();
  }, [fetchSeguimiento]);

  const handleDayClick = (comida: Seguimiento) => {
    setComidaSeleccionada(comida);
    setModalOpen(true);
  };

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

  const seguimientoPorDia: { [key: string]: Seguimiento[] } = {};
  diasSemana.forEach((dia) => {
    seguimientoPorDia[dia] = seguimiento.filter((s) => s.diaSemana.toLowerCase() === dia);
  });

  return (
    <div className="p-4 max-w-7xl mx-auto mt-10">
      <div className="relative flex justify-center items-center mb-6">
      <h2 className="text-2xl font-bold">Semana {semanaActual}</h2>
      <button
        onClick={async () => {
          const confirm = await Swal.fire({
            title: '¿Estás seguro?',
            text: '¿Quieres avanzar a la próxima semana?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonText: 'Sí, avanzar',
            cancelButtonText: 'Cancelar',
          });

          if (confirm.isConfirmed) {
            setSemanaActual((prev) => prev + 1);

            await Swal.fire({
              title: 'Semana cambiada',
              text: 'Has avanzado a la semana siguiente.',
              icon: 'success',
              timer: 1500,
              showConfirmButton: false,
            });
          }
        }}
        className="absolute right-0 text-2xl px-3"
      >
        ➡️
      </button>
    </div>

      <div className="overflow-x-auto">
        <table className="table-auto border border-gray-300 w-full text-center">
          <thead>
            <tr>
              <th className="bg-gray-100 p-2 border border-gray-300">Comida</th>
              {diasSemana.map((dia) => (
                <th key={dia} className="bg-gray-100 p-2 border border-gray-300 uppercase">
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
                  const comida = seguimientoPorDia[dia]
                    ?.find((c) => c.comida.toLowerCase() === tipo);
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
            <button className="px-4 py-2 bg-gray-300 rounded" onClick={() => setModalOpen(false)}>
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
  );
}

export default SeguimientoPage;
