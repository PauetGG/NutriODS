import Modal from "react-modal";
import type { Seguimiento } from "../hooks/useSeguimientoDieta";

type Props = {
  isOpen: boolean;
  comida: Seguimiento | null;
  onClose: () => void;
  onGuardar: (comidaActualizada: Seguimiento) => void;
  setComida: (comida: Seguimiento) => void;
};

export const ModalComida = ({
  isOpen,
  comida,
  onClose,
  onGuardar,
  setComida,
}: Props) => {
  if (!comida) return null;

  return (
    <Modal
      isOpen={isOpen}
      onRequestClose={onClose}
      className="bg-white p-6 rounded-md max-w-md w-full border border-black/20 shadow-2xl z-50"
      overlayClassName="fixed inset-0 flex items-center justify-center bg-black/30 backdrop-blur-sm"
    >
      <h2 className="text-xl font-bold mb-2 capitalize">{comida.comida}</h2>

      <p className="text-gray-700 mb-1 text-sm">
        <strong>Nombre:</strong> {comida.comidaModelo.nombre}
      </p>

      <p className="text-gray-700 mb-3 text-sm">
        <strong>Calorías totales:</strong> {comida.comidaModelo.caloriasTotales} kcal
      </p>

      {comida.comidaModelo.ingredientes?.length > 0 && (
        <div className="mb-4">
          <p className="text-gray-800 font-semibold mb-1 text-sm">Ingredientes:</p>
          <ul className="list-disc list-inside text-sm text-gray-600 space-y-1">
            {comida.comidaModelo.ingredientes.map((ci) => (
              <li key={ci.id}>
                {ci.ingrediente?.nombre} – {ci.cantidad} {ci.unidad}
              </li>
            ))}
          </ul>
        </div>
      )}

      <label className="flex items-center mb-3 gap-2 text-sm text-gray-700">
        <input
          type="checkbox"
          checked={comida.consumido}
          onChange={(e) =>
            setComida({ ...comida, consumido: e.target.checked })
          }
        />
        He consumido esta comida
      </label>

      <div className="mb-4 space-y-2">
        {[
          "He comido menos cantidad",
          "No me ha gustado",
          "Me ha sentado mal",
          "Me ha gustado mucho"
        ].map((opcion) => (
          <label key={opcion} className="flex items-center gap-2 text-sm text-gray-700">
            <input
              type="checkbox"
              checked={comida.notas?.includes(opcion) || false}
              onChange={(e) => {
                const notasActuales = comida.notas?.split(", ").filter(Boolean) || [];
                const nuevasNotas = e.target.checked
                  ? [...notasActuales, opcion]
                  : notasActuales.filter((n) => n !== opcion);
                setComida({ ...comida, notas: nuevasNotas.join(", ") });
              }}
            />
            {opcion}
          </label>
        ))}
      </div>

      <div className="flex justify-end gap-2 mt-2">
        <button className="px-4 py-2 bg-gray-300 rounded text-sm" onClick={onClose}>
          Cancelar
        </button>
        <button
          className="px-4 py-2 bg-green-600 text-white rounded text-sm"
          onClick={() => onGuardar(comida)}
        >
          Guardar
        </button>
      </div>
    </Modal>
  );
};
