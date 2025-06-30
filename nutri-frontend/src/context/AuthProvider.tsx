import { useEffect, useState } from "react";
import { AuthContext } from "./AuthContext";

export const AuthProvider = ({ children }: { children: React.ReactNode }) => {
  const [id, setId] = useState<number | null>(null);
  const [username, setUsername] = useState<string | null>(null);
  const [nombre, setNombre] = useState<string | null>(null);

  useEffect(() => {
    const storedId = localStorage.getItem("usuarioId");
    const storedUsername = localStorage.getItem("username");
    const storedNombre = localStorage.getItem("nombre");

    if (storedId) setId(Number(storedId));
    if (storedUsername) setUsername(storedUsername);
    if (storedNombre) setNombre(storedNombre);
  }, []);

  const login = (id: number, username: string, nombre: string) => {
    localStorage.setItem("usuarioId", id.toString());
    localStorage.setItem("username", username);
    localStorage.setItem("nombre", nombre);

    setId(id);
    setUsername(username);
    setNombre(nombre);
  };

  const logout = () => {
    localStorage.removeItem("usuarioId");
    localStorage.removeItem("username");
    localStorage.removeItem("nombre");

    setId(null);
    setUsername(null);
    setNombre(null);
  };

  return (
    <AuthContext.Provider value={{ id, username, nombre, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
};
