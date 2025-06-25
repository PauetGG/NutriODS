import React, { useState, useEffect } from "react";

const CompletarPerfil = () => {
  const [formData, setFormData] = useState({
    altura: "",
    peso: "",
    fecha_nacimiento: "",
    genero: "otro",
    objetivo: "",
    alergias: "",
    enfermedades: "",
    preferencias_comida: "",
    actividad_fisica: "moderado",
  });

  const [mensaje, setMensaje] = useState("");

  useEffect(() => {
    const datosGuardados = localStorage.getItem("perfil_completo");
    if (datosGuardados) {
      setFormData(JSON.parse(datosGuardados));
    }
  }, []);

  const manejarCambio = (
    e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>
  ) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const manejarSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    localStorage.setItem("perfil_completo", JSON.stringify(formData));
    setMensaje("✅ Perfil guardado correctamente");
  };

  return (
    <div className="max-w-md mx-auto mt-10 p-8 bg-white rounded-xl shadow-lg">
      <h2 className="text-3xl font-bold mb-6 text-center text-gray-800">Completa tu perfil</h2>
      <form onSubmit={manejarSubmit} className="space-y-6" noValidate>
        <div>
          <label htmlFor="altura" className="block font-medium mb-1 text-gray-700">Altura (cm)</label>
          <input
            id="altura"
            type="number"
            name="altura"
            value={formData.altura}
            onChange={manejarCambio}
            className="w-full border border-gray-300 rounded-md px-4 py-3 shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500"
          />
        </div>
        <div>
          <label htmlFor="peso" className="block font-medium mb-1 text-gray-700">Peso (kg)</label>
          <input
            id="peso"
            type="number"
            name="peso"
            value={formData.peso}
            onChange={manejarCambio}
            className="w-full border border-gray-300 rounded-md px-4 py-3 shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500"
          />
        </div>
        <div>
          <label htmlFor="fecha_nacimiento" className="block font-medium mb-1 text-gray-700">Fecha de nacimiento</label>
          <input
            id="fecha_nacimiento"
            type="date"
            name="fecha_nacimiento"
            value={formData.fecha_nacimiento}
            onChange={manejarCambio}
            className="w-full border border-gray-300 rounded-md px-4 py-3 shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500"
          />
        </div>
        <div>
          <label htmlFor="genero" className="block font-medium mb-1 text-gray-700">Género</label>
          <select
            id="genero"
            name="genero"
            value={formData.genero}
            onChange={manejarCambio}
            className="w-full border border-gray-300 rounded-md px-4 py-3 shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500"
          >
            <option value="masculino">Masculino</option>
            <option value="femenino">Femenino</option>
            <option value="otro">Otro</option>
          </select>
        </div>
        <div>
          <label htmlFor="objetivo" className="block font-medium mb-1 text-gray-700">Objetivo</label>
          <textarea
            id="objetivo"
            name="objetivo"
            value={formData.objetivo}
            onChange={manejarCambio}
            rows={3}
            className="w-full border border-gray-300 rounded-md px-4 py-3 shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500"
          />
        </div>
        <div>
          <label htmlFor="alergias" className="block font-medium mb-1 text-gray-700">Alergias</label>
          <textarea
            id="alergias"
            name="alergias"
            value={formData.alergias}
            onChange={manejarCambio}
            rows={2}
            className="w-full border border-gray-300 rounded-md px-4 py-3 shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500"
          />
        </div>
        <div>
          <label htmlFor="enfermedades" className="block font-medium mb-1 text-gray-700">Enfermedades</label>
          <textarea
            id="enfermedades"
            name="enfermedades"
            value={formData.enfermedades}
            onChange={manejarCambio}
            rows={2}
            className="w-full border border-gray-300 rounded-md px-4 py-3 shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500"
          />
        </div>
        <div>
          <label htmlFor="preferencias_comida" className="block font-medium mb-1 text-gray-700">Preferencias de comida</label>
          <textarea
            id="preferencias_comida"
            name="preferencias_comida"
            value={formData.preferencias_comida}
            onChange={manejarCambio}
            rows={2}
            className="w-full border border-gray-300 rounded-md px-4 py-3 shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500"
          />
        </div>
        <div>
          <label htmlFor="actividad_fisica" className="block font-medium mb-1 text-gray-700">Actividad física</label>
          <select
            id="actividad_fisica"
            name="actividad_fisica"
            value={formData.actividad_fisica}
            onChange={manejarCambio}
            className="w-full border border-gray-300 rounded-md px-4 py-3 shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500"
          >
            <option value="bajo">Bajo</option>
            <option value="moderado">Moderado</option>
            <option value="alto">Alto</option>
          </select>
        </div>

        <button
          type="submit"
          className="w-full bg-green-600 text-white py-3 rounded-md font-semibold hover:bg-green-700 transition duration-300"
        >
          Guardar Perfil
        </button>
      </form>

      {mensaje && <p className="mt-6 text-green-600 text-center font-semibold">{mensaje}</p>}
    </div>
  );
};

export default CompletarPerfil;
