import { useState } from "react";
import logo from "../assets/logo.png";
import { useAuth } from "../context/useAuth";
import LoginModal from "../components/LoginModal";
import RegisterModal from "../components/RegisterModal";
import { Link } from "react-router-dom";


function Header() {
  const { nombre, logout } = useAuth();
  const [mostrarLoginModal, setMostrarLoginModal] = useState(false);
  const [mostrarRegisterModal, setMostrarRegisterModal] = useState(false);

  const handleLogout = () => {
    logout();
  };

  return (
   <header className="relative w-full bg-white shadow-sm pb-2 pt-2 ">
  <div className="absolute top-12 left-1/2 transform -translate-x-1/2 -translate-y-1/2 z-50">
    <Link to="/">
      <div className="border-2 border-black rounded-full p-2 bg-white cursor-pointer">
        <img src={logo} alt="Logo BioNut" className="h-16 w-auto" />
      </div>
    </Link>
  </div>

    {/* Nav + Botón login/logout alineados */}
    <div className="flex justify-between items-center px-6 h-full">
      <nav className="flex space-x-6 text-gray-700 font-medium">
        <Link to="/dieta" className="hover:text-green-600">Generar Dieta</Link>
        <a href="#" className="hover:text-green-600">Recetas</a>
        <a href="#" className="hover:text-green-600">Foro</a>
        <a href="#" className="hover:text-green-600">Educación</a>
      </nav>

      <div className="relative group inline-block">
        <div className="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-lg font-semibold cursor-pointer">
          <button
            onClick={() => {
              if (!nombre) setMostrarLoginModal(true);
            }}
            className="w-full h-full"
          >
            {nombre ? `Hola, ${nombre}` : "Iniciar sesión"}
          </button>
        </div>

        {nombre && (
          <div className="absolute top-full right-0 bg-white border rounded shadow-md z-50 
                          w-36 opacity-0 group-hover:opacity-100 
                          pointer-events-none group-hover:pointer-events-auto 
                          transition-opacity duration-200">
            <button
              onClick={handleLogout}
              className="w-full text-left px-4 py-2 text-sm text-red-600 hover:bg-red-50"
            >
              Cerrar sesión
            </button>
          </div>
        )}
      </div>
    </div>

      {/* Modales */}
      {mostrarLoginModal && (
        <LoginModal
          onClose={() => setMostrarLoginModal(false)}
          onOpenRegister={() => {
            setMostrarLoginModal(false);
            setMostrarRegisterModal(true);
          }}
        />
      )}

      {mostrarRegisterModal && (
        <RegisterModal
          onClose={() => setMostrarRegisterModal(false)}
          onOpenLogin={() => {
            setMostrarRegisterModal(false);
            setMostrarLoginModal(true);
          }}
        />
      )}
    </header>
  );
}

export default Header;
