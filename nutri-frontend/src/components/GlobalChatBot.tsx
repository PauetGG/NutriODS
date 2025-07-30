import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Card, ScrollArea, Title, Divider } from '@mantine/core';
import ChatBot from './ChatBot';

export default function GlobalChatBot() {
  const [isOpen, setIsOpen] = useState(false);
  const toggleChat = () => setIsOpen(!isOpen);

  return (
    <div className="fixed bottom-0 right-4 z-50 w-[360px]">
      <AnimatePresence>
        <motion.div
          initial={{ height: "60px" }}
          animate={{ height: isOpen ? "480px" : "60px" }}
          exit={{ height: "60px" }}
          transition={{ duration: 0.3, ease: "easeInOut" }}
          className="overflow-hidden"
        >
          <Card
            shadow="xl"
            radius="lg"
            withBorder
            className="h-full flex flex-col bg-white/90 border-[2px] border-emerald-500 backdrop-blur-lg"
            style={{
              boxShadow: "0 0 35px rgba(16, 185, 129, 0.25)",
              borderRadius: "1rem",
            }}
          >
            {/* HEADER con toggle */}
            <div
              className="flex items-center justify-center px-4 py-3 bg-emerald-600 text-white cursor-pointer rounded-t-md"
              onClick={toggleChat}
            >
              <Title order={4} className="text-base font-semibold">
                Nuti Asistente
              </Title>
            </div>

            <Divider color="emerald.5" />

            {/* Contenido del chat */}
            {isOpen && (
              <ScrollArea className="flex-1 p-3">
                <ChatBot />
              </ScrollArea>
            )}
          </Card>
        </motion.div>
      </AnimatePresence>
    </div>
  );
}
