import { useState } from "react";
import { motion } from 'framer-motion';
import { FaTimes, FaPenFancy } from 'react-icons/fa';

export interface CrearTemaFormProps {
  onClose: () => void;
  onSubmit?: (formData: { titulo: string; contenido: string; categoria: string }) => void;
  categorias?: string[];
}

export const CrearTemaForm = ({ onClose, onSubmit, categorias = ["general", "dieta", "recetas", "entrenamiento"] }: CrearTemaFormProps) => {
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
    if (onSubmit) onSubmit(formData);
  };

  // Cerrar modal al hacer click en el fondo
  const handleBackdropClick = (e: React.MouseEvent<HTMLDivElement>) => {
    if (e.target === e.currentTarget) {
      onClose();
    }
  };

  return (
    <motion.div
      className="fixed inset-0 flex items-center justify-center  bg-opacity-30 backdrop-blur-sm z-[9998]"
      onClick={handleBackdropClick}
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
    >
      <motion.div
        initial={{ scale: 0.95, opacity: 0 }}
        animate={{ scale: 1, opacity: 1 }}
        exit={{ scale: 0.95, opacity: 0 }}
        transition={{ duration: 0.25 }}
        className="relative w-full max-w-2xl mx-4 bg-white border border-emerald-200 rounded-2xl shadow-2xl p-8 space-y-6"
      >
        {/* Botón de cierre */}
        <button
          type="button"
          onClick={onClose}
          className="absolute top-4 right-4 text-emerald-400 hover:text-emerald-700 text-2xl font-bold focus:outline-none transition-colors"
          aria-label="Cerrar"
        >
          <FaTimes />
        </button>
        <h2 className="text-3xl font-extrabold text-center text-emerald-700 flex items-center justify-center gap-2 drop-shadow">
          <FaPenFancy className="text-emerald-500" /> Crear nuevo tema
        </h2>
        <form onSubmit={handleSubmit} className="space-y-6">
          {/* Título */}
          <div>
            <label htmlFor="titulo" className="block text-sm font-semibold text-emerald-700 mb-1">
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
              className="w-full px-4 py-2 border border-emerald-200 rounded-xl shadow focus:ring-2 focus:ring-emerald-400 focus:outline-none bg-emerald-50/30"
            />
          </div>
          {/* Categoría */}
          <div>
            <label htmlFor="categoria" className="block text-sm font-semibold text-emerald-700 mb-1">
              Categoría
            </label>
            <select
              name="categoria"
              id="categoria"
              required
              value={formData.categoria}
              onChange={handleChange}
              className="w-full px-4 py-2 border border-emerald-200 rounded-xl shadow focus:ring-2 focus:ring-emerald-400 focus:outline-none bg-emerald-50/30"
            >
              {categorias.map((cat) => (
                <option key={cat} value={cat}>
                  {cat.charAt(0).toUpperCase() + cat.slice(1)}
                </option>
              ))}
            </select>
          </div>
          {/* Contenido */}
          <div>
            <label htmlFor="contenido" className="block text-sm font-semibold text-emerald-700 mb-1">
              Contenido
            </label>
            <textarea
              name="contenido"
              id="contenido"
              required
              rows={1}
              value={formData.contenido}
              onChange={handleChange}
              placeholder="Comparte tu pregunta, reflexión o información aquí..."
              className="w-full px-4 py-2 border border-emerald-200 rounded-xl shadow focus:ring-2 focus:ring-emerald-400 focus:outline-none bg-emerald-50/30 resize-none"
              style={{ minHeight: '40px', maxHeight: '300px', overflowY: 'auto', resize: 'none' }}
            />
          </div>
          {/* Botón */}
          <motion.button
            type="submit"
            whileHover={{ scale: 1.04 }}
            whileTap={{ scale: 0.97 }}
            className="w-full py-3 px-4 bg-gradient-to-r from-green-400 via-emerald-500 to-emerald-700 hover:from-emerald-500 hover:to-green-600 text-white font-extrabold rounded-2xl shadow-xl transition-all text-xl flex items-center justify-center gap-2 drop-shadow-lg"
          >
            <FaPenFancy className="text-2xl mr-2" /> Publicar tema
          </motion.button>
        </form>
      </motion.div>
    </motion.div>
  );
};
