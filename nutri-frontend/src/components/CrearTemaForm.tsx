import { useState } from "react";

export const CrearTemaForm = () => {
  const [formData, setFormData] = useState({
    titulo: "",
    contenido: "",
    categoria: "general",
  });

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>
  ) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    console.log("Enviado:", formData);
  };

  return (
    <form
      onSubmit={handleSubmit}
      className="max-w-2xl mx-auto bg-white border border-gray-200 rounded-xl shadow-lg p-8 space-y-6"
    >
      <h2 className="text-3xl font-bold text-center text-gray-800">📝 Crear nuevo tema</h2>

      {/* Título */}
      <div>
        <label htmlFor="titulo" className="block text-sm font-medium text-gray-700 mb-1">
          Título del tema
        </label>
        <input
          type="text"
          name="titulo"
          id="titulo"
          required
          value={formData.titulo}
          onChange={handleChange}
          placeholder="Ej. ¿Qué opinan sobre los ayunos intermitentes?"
          className="w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-2 focus:ring-green-500 focus:outline-none"
        />
      </div>

      {/* Categoría */}
      <div>
        <label htmlFor="categoria" className="block text-sm font-medium text-gray-700 mb-1">
          Categoría
        </label>
        <select
          name="categoria"
          id="categoria"
          required
          value={formData.categoria}
          onChange={handleChange}
          className="w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-2 focus:ring-green-500 focus:outline-none"
        >
          <option value="general">General</option>
          <option value="dieta">Dieta</option>
          <option value="recetas">Recetas</option>
          <option value="entrenamiento">Entrenamiento</option>
        </select>
      </div>

      {/* Contenido */}
      <div>
        <label htmlFor="contenido" className="block text-sm font-medium text-gray-700 mb-1">
          Contenido
        </label>
        <textarea
          name="contenido"
          id="contenido"
          required
          rows={6}
          value={formData.contenido}
          onChange={handleChange}
          placeholder="Comparte tu pregunta, reflexión o información aquí..."
          className="w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-2 focus:ring-green-500 focus:outline-none resize-none"
        />
      </div>

      {/* Botón */}
      <button
        type="submit"
        className="w-full py-3 px-4 bg-green-600 hover:bg-green-700 text-white font-semibold rounded-lg shadow-md transition duration-200 text-lg"
      >
        Publicar tema
      </button>
    </form>
  );
};
