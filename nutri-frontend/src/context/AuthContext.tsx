import { createContext } from "react";

interface AuthContextType {
  id: number | null;
  username: string | null;
  nombre: string | null;
  login: (id: number, username: string, nombre: string) => void;
  logout: () => void;
}

export const AuthContext = createContext<AuthContextType>({
  id: null,
  username: null,
  nombre: null,
  login: () => {},
  logout: () => {},
});
