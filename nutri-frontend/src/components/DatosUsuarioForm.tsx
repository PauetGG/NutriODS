import { useState } from "react";
import type { DatosUsuarioDTO } from "../types/DatosUsuarioDTO";
import { useAuth } from "../context/useAuth";
import Swal from "sweetalert2";
import { motion } from "framer-motion";
import { FaTimes, FaUserEdit } from "react-icons/fa";

type Props = {
  datosIniciales: DatosUsuarioDTO | null;
  onClose?: () => void;
};

// Helper para fetch con timeout
function fetchWithTimeout(
  resource: RequestInfo | URL,
  options: RequestInit = {},
  timeout = 10000
): Promise<Response> {
  return Promise.race([
    fetch(resource, options),
    new Promise<Response>((_, reject) =>
      setTimeout(() => reject(new Error("Tiempo de espera agotado")), timeout)
    ),
  ]);
}

function DatosUsuarioForm({ datosIniciales, onClose }: Props) {
  const [formData, setFormData] = useState<DatosUsuarioDTO>({
    altura: datosIniciales?.altura || "",
    peso: datosIniciales?.peso || "",
    fechaNacimiento: datosIniciales?.fechaNacimiento || "",
    genero: datosIniciales?.genero || "",
    objetivo: datosIniciales?.objetivo || "",
    alergias: datosIniciales?.alergias || [],
    enfermedades: datosIniciales?.enfermedades || [],
    preferencias: datosIniciales?.preferencias || [],
    actividad: datosIniciales?.actividad || "",
  });

  const [numeroComidasDia, setNumeroComidasDia] = useState<number>(4);
  const { id } = useAuth();

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleMultiChange = (
    e: React.ChangeEvent<HTMLInputElement>,
    field: keyof DatosUsuarioDTO
  ) => {
    const value = e.target.value;
    const checked = e.target.checked;
    const current = formData[field] as string[];
    const updated = checked ? [...current, value] : current.filter((v) => v !== value);
    setFormData({ ...formData, [field]: updated });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!id) {
      await Swal.fire("Error", "No se ha encontrado el ID del usuario.", "error");
      return;
    }

    let errorMsg = "Ocurrió un error durante el proceso.";
    try {
      // Guardar datos personales
      const updateRes = await fetchWithTimeout(`http://localhost:8080/api/usuarios/${id}/datos`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          ...formData,
          alergias: formData.alergias.length ? formData.alergias : null,
          enfermedades: formData.enfermedades.length ? formData.enfermedades : null,
          preferencias: formData.preferencias.length ? formData.preferencias : null,
        }),
      });

      if (!updateRes.ok) {
        errorMsg = "Error al guardar los datos personales";
        throw new Error(errorMsg);
      }

      // Generar dieta personalizada
      const dietaRes = await fetchWithTimeout("http://localhost:8080/api/dietas/generar", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          usuarioId: id,
          nombreDieta: "Dieta personalizada",
          descripcion: "Generada automáticamente según tus datos",
          numeroComidasDia,
        }),
      });

      if (!dietaRes.ok) {
        errorMsg = "Error al generar la dieta";
        throw new Error(errorMsg);
      }

      const dieta = await dietaRes.json();

      // Generar seguimiento del mes
      const seguimientoRes = await fetchWithTimeout(
        `http://localhost:8080/api/seguimiento-dieta/generar-mes/${dieta.id}`,
        { method: "POST" }
      );

      if (!seguimientoRes.ok) {
        errorMsg = "Error al crear el seguimiento";
        throw new Error(errorMsg);
      }

      await Swal.fire({
        icon: "success",
        title: "¡Dieta generada!",
        text: "Tu dieta y seguimiento se han creado correctamente.",
        confirmButtonColor: "#10b981",
      });

      if (onClose) onClose();
    } catch (error: unknown) {
      console.error("Error:", error);
      const errMsg = error instanceof Error ? error.message : "";
      await Swal.fire("Oops...", `${errorMsg}${errMsg ? "\n" + errMsg : ""}`, "error");
    }
  };

  return (
      <motion.div
      className="fixed inset-0 flex items-center justify-center bg-opacity-30 backdrop-blur-sm z-[9998]"
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
    >
      <motion.div
        initial={{ scale: 0.95, opacity: 0 }}
        animate={{ scale: 1, opacity: 1 }}
        exit={{ scale: 0.95, opacity: 0 }}
        transition={{ duration: 0.25 }}
        className="relative w-full max-w-2xl mx-4 bg-white border border-emerald-200 rounded-2xl shadow-2xl p-8 space-y-6 overflow-y-auto max-h-[90vh]"
      >
        <button
          type="button"
          onClick={onClose}
          className="absolute top-4 right-4 text-emerald-400 hover:text-emerald-700 text-2xl font-bold focus:outline-none transition-colors"
          aria-label="Cerrar"
        >
          <FaTimes />
        </button>

        <h2 className="text-3xl font-extrabold text-center text-emerald-700 flex items-center justify-center gap-2 drop-shadow">
          <FaUserEdit className="text-emerald-500" /> Tus datos personales
        </h2>

        <form onSubmit={handleSubmit} className="space-y-5">
          {/* Altura y Peso */}
          <div className="flex gap-4">
            <input
              type="number"
              step="0.01"
              name="altura"
              value={formData.altura}
              onChange={handleChange}
              placeholder="Altura (m)"
              className="w-1/2 px-4 py-2 border border-emerald-200 rounded-xl shadow focus:ring-2 focus:ring-emerald-400 focus:outline-none bg-emerald-50/30"
              required
            />
            <input
              type="number"
              step="0.1"
              name="peso"
              value={formData.peso}
              onChange={handleChange}
              placeholder="Peso (kg)"
              className="w-1/2 px-4 py-2 border border-emerald-200 rounded-xl shadow focus:ring-2 focus:ring-emerald-400 focus:outline-none bg-emerald-50/30"
              required
            />
          </div>

          {/* Fecha nacimiento */}
          <input
            type="date"
            name="fechaNacimiento"
            value={formData.fechaNacimiento}
            onChange={handleChange}
            className="w-full px-4 py-2 border border-emerald-200 rounded-xl shadow focus:ring-2 focus:ring-emerald-400 focus:outline-none bg-emerald-50/30"
            required
          />

          {/* Selects */}
          {[
            { name: "genero", label: "Selecciona tu género", options: ["masculino", "femenino", "otro"] },
            {
              name: "objetivo",
              label: "Selecciona tu objetivo",
              options: ["perder_peso", "mantener", "ganar_peso"],
            },
            {
              name: "actividad",
              label: "Nivel de actividad",
              options: ["sedentario", "ligero", "moderado", "intenso", "muy intenso"],
            },
          ].map((field) => (
            <select
              key={field.name}
              name={field.name}
              value={formData[field.name as keyof typeof formData] as string}
              onChange={handleChange}
              className="w-full px-4 py-2 border border-emerald-200 rounded-xl shadow focus:ring-2 focus:ring-emerald-400 focus:outline-none bg-emerald-50/30"
              required
            >
              <option value="">{field.label}</option>
              {field.options.map((opt) => (
                <option key={opt} value={opt}>
                  {opt.charAt(0).toUpperCase() + opt.slice(1).replace("_", " ")}
                </option>
              ))}
            </select>
          ))}

          {/* Alergias */}
          <fieldset className="border border-emerald-200 rounded-xl p-4 bg-emerald-50/10 shadow-inner">
            <legend className="text-sm font-semibold text-emerald-700 mb-2">Alergias</legend>
            <div className="grid grid-cols-2 gap-2">
              {["gluten", "lactosa", "frutos secos", "marisco", "soja", "huevo"].map((a) => (
                <label key={a} className="flex items-center text-sm text-gray-700">
                  <input
                    type="checkbox"
                    value={a}
                    checked={formData.alergias.includes(a)}
                    onChange={(e) => handleMultiChange(e, "alergias")}
                    className="mr-2 accent-emerald-500"
                  />
                  {a}
                </label>
              ))}
            </div>
          </fieldset>

          {/* Enfermedades */}
          <fieldset className="border border-emerald-200 rounded-xl p-4 bg-emerald-50/10 shadow-inner">
            <legend className="text-sm font-semibold text-emerald-700 mb-2">Enfermedades</legend>
            <div className="grid grid-cols-2 gap-2">
              {["diabetes", "hipertension", "obesidad", "anemia", "renal", "hipotiroidismo", "colon irritable"].map((e) => (
                <label key={e} className="flex items-center text-sm text-gray-700">
                  <input
                    type="checkbox"
                    value={e}
                    checked={formData.enfermedades.includes(e)}
                    onChange={(ev) => handleMultiChange(ev, "enfermedades")}
                    className="mr-2 accent-emerald-500"
                  />
                  {e}
                </label>
              ))}
            </div>
          </fieldset>

          {/* Preferencias */}
          <input
            type="text"
            name="preferencias"
            value={formData.preferencias.join(", ")}
            onChange={(e) =>
              setFormData({
                ...formData,
                preferencias: e.target.value.split(",").map((p) => p.trim()).filter((p) => p !== ""),
              })
            }
            placeholder="Preferencias alimentarias (ej. vegano, sin azúcares...)"
            className="w-full px-4 py-2 border border-emerald-200 rounded-xl shadow focus:ring-2 focus:ring-emerald-400 focus:outline-none bg-emerald-50/30"
          />

          {/* Número de comidas */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              ¿Cuántas comidas quieres al día?
            </label>
            <select
              value={numeroComidasDia}
              onChange={(e) => setNumeroComidasDia(parseInt(e.target.value))}
              className="w-full px-4 py-2 border border-emerald-200 rounded-xl shadow focus:ring-2 focus:ring-emerald-400 focus:outline-none bg-emerald-50/30"
              required
            >
              <option value={3}>3 comidas</option>
              <option value={4}>4 comidas</option>
              <option value={5}>5 comidas</option>
            </select>
          </div>

          {/* Botón enviar */}
          <motion.button
            type="submit"
            whileHover={{ scale: 1.04 }}
            whileTap={{ scale: 0.97 }}
            className="w-full py-3 px-4 bg-gradient-to-r from-green-400 via-emerald-500 to-emerald-700 hover:from-emerald-500 hover:to-green-600 text-white font-extrabold rounded-2xl shadow-xl transition-all text-xl flex items-center justify-center gap-2 drop-shadow-lg"
          >
            Guardar y generar dieta
          </motion.button>
        </form>
      </motion.div>
    </motion.div>
  );
}

export default DatosUsuarioForm;
