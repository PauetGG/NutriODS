import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { FaRobot, FaTimes } from 'react-icons/fa';
import ChatBot from './ChatBot'; // Assuming the original ChatBot component is still here

export default function GlobalChatBot() {
  const [isOpen, setIsOpen] = useState(false);

  const toggleChat = () => {
    setIsOpen(!isOpen);
  };

  return (
    <div className="fixed bottom-4 right-4 z-50">
      <motion.button
        onClick={toggleChat}
        className="bg-emerald-500 text-white rounded-full p-4 shadow-lg hover:bg-emerald-600 transition-colors focus:outline-none focus:ring-2 focus:ring-emerald-400 focus:ring-opacity-75"
        whileHover={{ scale: 1.1 }}
        whileTap={{ scale: 0.9 }}
      >
        {isOpen ? <FaTimes size={24} /> : <FaRobot size={24} />}
      </motion.button>

      <AnimatePresence>
        {isOpen && (
          <motion.div
            initial={{ opacity: 0, y: 50, scale: 0.8 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: 50, scale: 0.8 }}
            transition={{ type: "spring", damping: 20, stiffness: 300 }}
            className="absolute bottom-20 right-0 w-80 h-96 bg-white rounded-lg shadow-xl flex flex-col overflow-hidden"
          >
            <div className="flex justify-between items-center bg-emerald-500 text-white p-3 rounded-t-lg">
              <h3 className="text-lg font-semibold">Nuti Asistente</h3>
              <button onClick={toggleChat} className="text-white hover:text-gray-200 focus:outline-none">
                <FaTimes size={20} />
              </button>
            </div>
            <div className="flex-1 overflow-y-auto p-4">
              <ChatBot />
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}
