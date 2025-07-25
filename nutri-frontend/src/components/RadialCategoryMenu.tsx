import React, { useState } from 'react';
import { IconCategory } from '@tabler/icons-react';

interface Category {
  value: string;
  label: string;
  icon: React.ReactNode;
}

interface RadialCategoryMenuProps {
  categories: Category[];
  value: string;
  onSelect: (value: string) => void;
  selectedLabel?: string;
  selectedIcon?: React.ReactNode;
  open?: boolean;
  onOpenChange?: (open: boolean) => void;
}

const RADIUS_CLOSED = 0;
const RADIUS_OPEN = 170;
const SIZE_CLOSED = 80;
const SIZE_OPEN = 160;
const OPTION_SIZE_CLOSED = 64;
const OPTION_SIZE_OPEN = 110;

export default function RadialCategoryMenu({ categories, value, onSelect, selectedLabel, selectedIcon, open: openProp, onOpenChange }: RadialCategoryMenuProps) {
  const [internalOpen, setInternalOpen] = useState(false);
  const isControlled = openProp !== undefined;
  const open = isControlled ? openProp : internalOpen;

  const setOpen = (val: boolean) => {
    if (onOpenChange) onOpenChange(val);
    if (!isControlled) setInternalOpen(val);
  };

  const handleSelect = (cat: Category) => {
    onSelect(cat.value);
    setOpen(false);
  };

  const radius = open ? RADIUS_OPEN : RADIUS_CLOSED;
  const centerSize = open ? SIZE_OPEN : SIZE_CLOSED;
  const optionSize = open ? OPTION_SIZE_OPEN : OPTION_SIZE_CLOSED;

  return (
    <div className="relative flex items-center justify-center" style={{ width: SIZE_CLOSED, height: SIZE_CLOSED }}>
      {/* Categorías en círculo (solo renderizar si open) */}
      {open && categories.map((cat, i) => {
        const angle = (2 * Math.PI * i) / categories.length - Math.PI / 2;
        const x = Math.cos(angle) * radius;
        const y = Math.sin(angle) * radius;
        return (
          <button
            key={cat.value}
            onClick={() => handleSelect(cat)}
            className={`fixed flex flex-col items-center justify-center transition-all duration-300 z-40 bg-white shadow-lg rounded-full border-2 border-emerald-200 hover:bg-emerald-50 focus:outline-none ${value === cat.value ? 'ring-2 ring-emerald-400' : ''}`}
            style={{
              left: `calc(50vw + ${x}px - ${optionSize / 2}px)`,
              top: `calc(50vh + ${y}px - ${optionSize / 2}px)` ,
              width: optionSize,
              height: optionSize,
              transform: open ? 'scale(1)' : 'scale(0.5)',
              opacity: open ? 1 : 0,
            }}
            tabIndex={open ? 0 : -1}
            aria-label={cat.label}
          >
            <span className="text-4xl mb-1">{cat.icon}</span>
            <span className="text-sm font-semibold text-emerald-700 text-center leading-tight">{cat.label}</span>
          </button>
        );
      })}
      {/* Bola central rediseñada */}
      <button
        className={`flex items-center justify-center rounded-full border-4 border-white transition-all duration-300 z-50 relative group ${open ? 'scale-110' : ''}`}
        onClick={() => setOpen(!open)}
        aria-label="Seleccionar categoría"
        type="button"
        style={{
          width: centerSize,
          height: centerSize,
          position: open ? 'fixed' : 'relative',
          left: open ? '50vw' : undefined,
          top: open ? '50vh' : undefined,
          transform: open ? 'translate(-50%, -50%)' : undefined,
        }}
      >
        {/* Doble borde animado */}
        <span className="absolute inset-0 rounded-full border-4 border-emerald-300 animate-spin-slow pointer-events-none" style={{ borderStyle: 'dashed', opacity: 0.25 }} />
        {/* Gradiente animado */}
        <span className="absolute inset-0 rounded-full bg-gradient-to-br from-emerald-400 via-emerald-500 to-emerald-700 group-hover:brightness-110 transition-all duration-300 blur-sm opacity-80 animate-gradient-move" />
        {/* Icono y label de la categoría seleccionada o por defecto */}
        <span className="relative z-10 flex flex-col items-center">
          {selectedIcon ? selectedIcon : <IconCategory size={open ? 72 : 32} className="text-white drop-shadow-lg" />}
          <span className="text-base text-white font-bold mt-1 tracking-wide" style={{ textShadow: '0 2px 8px #059669' }}>{selectedLabel || 'Categoría'}</span>
        </span>
      </button>
      {/* Fondo semitransparente y difuminado al abrir */}
      {open && (
        <div
          className="fixed inset-0 bg-black/40 backdrop-blur-sm z-30"
          onClick={() => setOpen(false)}
          aria-hidden
        />
      )}
      {/* Animación de gradiente personalizada */}
      <style>{`
        @keyframes gradient-move {
          0% { background-position: 0% 50%; }
          50% { background-position: 100% 50%; }
          100% { background-position: 0% 50%; }
        }
        .animate-gradient-move {
          background-size: 200% 200%;
          animation: gradient-move 3s ease-in-out infinite;
        }
        .animate-spin-slow {
          animation: spin 4s linear infinite;
        }
      `}</style>
    </div>
  );
} 