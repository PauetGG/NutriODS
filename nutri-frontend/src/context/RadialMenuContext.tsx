import React, { createContext, useContext, useState } from 'react';

interface RadialMenuContextType {
  isOpen: boolean;
  setIsOpen: (open: boolean) => void;
}

const RadialMenuContext = createContext<RadialMenuContextType | undefined>(undefined);

export const RadialMenuProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [isOpen, setIsOpen] = useState(false);
  return (
    <RadialMenuContext.Provider value={{ isOpen, setIsOpen }}>
      {children}
    </RadialMenuContext.Provider>
  );
};

export const useRadialMenu = () => {
  const ctx = useContext(RadialMenuContext);
  if (!ctx) throw new Error('useRadialMenu debe usarse dentro de RadialMenuProvider');
  return ctx;
}; 