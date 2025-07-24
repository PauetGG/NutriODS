import React from 'react';
import { useNavigate } from 'react-router-dom';
import { FaArrowLeft } from 'react-icons/fa';
import ChatBot from '../components/ChatBot';

export default function SoportePage() {
  const navigate = useNavigate();
  return (
    <div className="min-h-[60vh] flex flex-col items-center justify-center bg-gradient-to-br from-emerald-50 via-white to-emerald-100">
      <div className="w-full max-w-xl mx-auto flex items-center mb-4">
        <button
          onClick={() => navigate(-1)}
          className="flex items-center gap-2 text-red-600 hover:text-red-800 font-semibold px-4 py-2 rounded-full transition-colors border border-red-100 bg-red-50 hover:bg-red-100 shadow-lg"
          style={{ minWidth: 90 }}
        >
          <FaArrowLeft className="text-xl" />
          Atrás
        </button>
      </div>
      <div className="bg-white/90 border border-emerald-200 rounded-2xl shadow-xl p-10 flex flex-col items-center mb-8">
        <h1 className="text-3xl font-extrabold text-emerald-700 mb-8">Soporte / Ayudas</h1>
        <ChatBot />
      </div>
      <div className="mb-8 text-center text-gray-700 text-base font-semibold">
        Si necesitas contactarnos: <span className="text-emerald-700">XXXXXXXXXXX</span>
        <span className="mx-2 text-gray-400">|</span>
        Nuestro correo es: <span className="text-emerald-700">XXXXXXXXX@gmail.com</span>
      </div>
    </div>
  );
} 