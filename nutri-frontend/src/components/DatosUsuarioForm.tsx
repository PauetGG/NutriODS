import { useState } from "react";
import type { DatosUsuarioDTO } from "../types/DatosUsuarioDTO";
import { useAuth } from "../context/useAuth";

type Props = {
  datosIniciales: DatosUsuarioDTO | null;
  onClose?: () => void;
};

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
  const { id } = useAuth(); // ✅ Usamos el ID directamente del contexto

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
      alert("No se ha encontrado el ID del usuario.");
      return;
    }

    try {
      // 1. Actualizar datos del usuario
      const updateRes = await fetch(`http://localhost:8080/api/usuarios/${id}/datos`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          ...formData,
          alergias: formData.alergias.length > 0 ? formData.alergias : null,
          enfermedades: formData.enfermedades.length > 0 ? formData.enfermedades : null,
          preferencias: formData.preferencias.length > 0 ? formData.preferencias : null,
        }),
      });

      if (!updateRes.ok) throw new Error("Error al guardar los datos");

      // 2. Generar dieta
      const dietaRes = await fetch("http://localhost:8080/api/dietas/generar", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          usuarioId: id,
          nombreDieta: "Dieta personalizada",
          descripcion: "Generada automáticamente según tus datos",
          numeroComidasDia,
        }),
      });

      if (!dietaRes.ok) throw new Error("Error al generar la dieta");

      const dieta = await dietaRes.json();

      // 3. Crear seguimiento para esa dieta
      const seguimientoRes = await fetch(
        `http://localhost:8080/api/seguimiento-dieta/generar-mes/${dieta.id}`,
        { method: "POST" }
      );
      
      if (!seguimientoRes.ok) throw new Error("Error al crear el seguimiento de la dieta");

      alert("¡Dieta y seguimiento generados correctamente!");
      if (onClose) onClose();
    } catch (error) {
      console.error("Error:", error);
      alert("Ocurrió un error durante el proceso.");
    }
  };


  return (
    <div className="fixed inset-0 bg-opacity-50 backdrop-blur-sm z-50 flex justify-center items-center">
      <div className="bg-white p-6 rounded-lg w-[500px] relative border border-black">
        <button
          onClick={onClose}
          className="absolute top-2 right-2 text-gray-500 hover:text-gray-700 cursor-pointer"
        >
          ✕
        </button>

        <h2 className="text-2xl font-bold mb-4 text-green-700">Tus datos personales</h2>

        <form onSubmit={handleSubmit} className="space-y-4 max-h-[80vh] overflow-y-auto pr-1">
          <div className="flex gap-4">
            <input
              type="number"
              step="0.01"
              name="altura"
              value={formData.altura}
              onChange={handleChange}
              placeholder="Altura (m)"
              className="w-1/2 p-2 border rounded"
              required
            />
            <input
              type="number"
              step="0.1"
              name="peso"
              value={formData.peso}
              onChange={handleChange}
              placeholder="Peso (kg)"
              className="w-1/2 p-2 border rounded"
              required
            />
          </div>

          <input
            type="date"
            name="fechaNacimiento"
            value={formData.fechaNacimiento}
            onChange={handleChange}
            className="w-full p-2 border rounded"
            required
          />

          <select
            name="genero"
            value={formData.genero}
            onChange={handleChange}
            className="w-full p-2 border rounded"
            required
          >
            <option value="">Selecciona tu género</option>
            <option value="masculino">Masculino</option>
            <option value="femenino">Femenino</option>
            <option value="otro">Otro</option>
          </select>

          <select
            name="objetivo"
            value={formData.objetivo}
            onChange={handleChange}
            className="w-full p-2 border rounded"
            required
          >
            <option value="">Selecciona tu objetivo</option>
            <option value="perder_peso">Perder peso</option>
            <option value="mantener">Mantener peso</option>
            <option value="ganar_peso">Ganar masa muscular</option>
          </select>

          <fieldset className="border rounded p-2">
            <legend className="text-sm font-medium text-gray-700">Alergias</legend>
            {["gluten", "lactosa", "frutos secos", "marisco", "soja", "huevo"].map((a) => (
              <label key={a} className="block">
                <input
                  type="checkbox"
                  value={a}
                  checked={formData.alergias.includes(a)}
                  onChange={(e) => handleMultiChange(e, "alergias")}
                  className="mr-2"
                />
                {a}
              </label>
            ))}
          </fieldset>

          <fieldset className="border rounded p-2">
            <legend className="text-sm font-medium text-gray-700">Enfermedades</legend>
            {[
              "diabetes",
              "hipertension",
              "obesidad",
              "anemia",
              "renal",
              "hipotiroidismo",
              "colon irritable",
            ].map((e) => (
              <label key={e} className="block">
                <input
                  type="checkbox"
                  value={e}
                  checked={formData.enfermedades.includes(e)}
                  onChange={(ev) => handleMultiChange(ev, "enfermedades")}
                  className="mr-2"
                />
                {e}
              </label>
            ))}
          </fieldset>

          <input
            type="text"
            name="preferencias"
            value={formData.preferencias.join(", ")}
            onChange={(e) =>
              setFormData({
                ...formData,
                preferencias: e.target.value
                  .split(",")
                  .map((p) => p.trim())
                  .filter((p) => p !== ""),
              })
            }
            placeholder="Preferencias alimentarias (ej. vegano, sin azúcares...)"
            className="w-full p-2 border rounded"
          />

          <select
            name="actividad"
            value={formData.actividad}
            onChange={handleChange}
            className="w-full p-2 border rounded"
            required
          >
            <option value="">Selecciona tu nivel de actividad</option>
            <option value="sedentario">Sedentario</option>
            <option value="ligero">Ligero</option>
            <option value="moderado">Moderado</option>
            <option value="intenso">Intenso</option>
            <option value="muy intenso">Muy intenso</option>
          </select>

          <div>
            <label className="block font-medium text-gray-700 mb-1">
              ¿Cuántas comidas quieres al día?
            </label>
            <select
              value={numeroComidasDia}
              onChange={(e) => setNumeroComidasDia(parseInt(e.target.value))}
              className="w-full p-2 border rounded"
              required
            >
              <option value={3}>3 comidas</option>
              <option value={4}>4 comidas</option>
              <option value={5}>5 comidas</option>
            </select>
          </div>

          <button
            type="submit"
            className="w-full bg-green-600 text-white py-2 rounded hover:bg-green-700 mt-2"
          >
            Guardar y generar dieta
          </button>
        </form>
      </div>
    </div>
  );
}

export default DatosUsuarioForm;