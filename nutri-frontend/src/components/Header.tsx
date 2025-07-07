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
    <>
      {/* Header */}
      <header className="sticky top-0 w-full bg-white/80 backdrop-blur-sm z-50 py-3 border-b border-gray-100">
        {/* Contenedor principal */}
        <div className="relative max-w-7xl mx-auto px-6">
          {/* Logo centrado */}
          <div className="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 z-50">
            <Link 
              to="/" 
              onClick={(e) => {
                e.preventDefault();
                window.scrollTo({ top: 0, behavior: "smooth" });
                window.location.href = "/";
              }}
              className="group block"
            >
              <div className="border-2 border-emerald-400 rounded-full p-2 bg-white shadow-md group-hover:shadow-lg group-hover:border-emerald-500 transition-all duration-300 group-hover:scale-110">
                <img 
                  src={logo} 
                  alt="Logo BioNut" 
                  className="h-14 w-auto transition-transform duration-300 group-hover:rotate-6" 
                />
              </div>
            </Link>
          </div>

          {/* Nav + Login */}
          <div className="flex justify-between items-center h-16">
            {/* Navegación izquierda */}
            <nav className="flex space-x-6">
              <Link 
                to="/dieta" 
                className="text-gray-700 hover:text-emerald-600 font-medium transition-colors duration-200 flex items-center relative group text-sm"
              >
                Generar Dieta
                <span className="absolute bottom-0 left-0 w-0 h-0.5 bg-emerald-500 group-hover:w-full transition-all duration-300"></span>
              </Link>
              
              <Link 
                to="/recetas" 
                className="text-gray-700 hover:text-emerald-600 font-medium transition-colors duration-200 flex items-center relative group text-sm"
              >
                Recetas
                <span className="absolute bottom-0 left-0 w-0 h-0.5 bg-emerald-500 group-hover:w-full transition-all duration-300"></span>
              </Link>
              
              <Link 
                to="/foro" 
                className="text-gray-700 hover:text-emerald-600 font-medium transition-colors duration-200 flex items-center relative group text-sm"
              >
                Foro
                <span className="absolute bottom-0 left-0 w-0 h-0.5 bg-emerald-500 group-hover:w-full transition-all duration-300"></span>
              </Link>

              {/* Menú Educación */}
              <div className="relative group h-full flex items-center">
                <button className="text-gray-700 hover:text-emerald-600 font-medium transition-colors duration-200 flex items-center text-sm">
                  <span>Educación</span>
                  <svg className="w-4 h-4 ml-1 transition-transform group-hover:rotate-180" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M19 9l-7 7-7-7"/>
                  </svg>
                </button>
                
                <div className="absolute top-full left-0 mt-1 w-48 bg-white rounded-lg shadow-xl border border-gray-100 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200 origin-top z-50">
                  <div className="py-1">
                    <Link 
                      to="/articulos" 
                      className="block px-4 py-2 text-gray-600 hover:bg-emerald-50 hover:text-emerald-700 transition-colors text-sm"
                    >
                      Artículos
                    </Link>
                    <Link 
                      to="/glosario" 
                      className="block px-4 py-2 text-gray-600 hover:bg-emerald-50 hover:text-emerald-700 transition-colors text-sm"
                    >
                      Glosario
                    </Link>
                    <Link 
                      to="/multimedia" 
                      className="block px-4 py-2 text-gray-600 hover:bg-emerald-50 hover:text-emerald-700 transition-colors text-sm"
                    >
                      Recursos
                    </Link>
                  </div>
                </div>
              </div>
            </nav>

            {/* Botón sesión */}
            <div className="relative group h-full flex items-center">
              <button
                onClick={() => !nombre && setMostrarLoginModal(true)}
                className={`px-4 py-2 rounded-full font-medium transition-all duration-300 flex items-center space-x-2 text-sm ${
                  nombre 
                    ? "bg-emerald-50 text-emerald-700 hover:bg-emerald-100 border border-emerald-200"
                    : "bg-gradient-to-r from-emerald-500 to-emerald-600 text-white hover:shadow-lg hover:shadow-emerald-200"
                }`}
              >
                {nombre ? (
                  <>
                    <span className="w-2 h-2 rounded-full bg-emerald-500"></span>
                    <span>Mi cuenta</span>
                  </>
                ) : (
                  <>
                    <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                    </svg>
                    <span>Iniciar sesión</span>
                  </>
                )}
              </button>

              {nombre && (
                <div className="absolute top-full right-0 mt-2 w-48 bg-white rounded-lg shadow-xl border border-gray-100 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200 origin-top-right z-50">
                  <div className="py-1">
                    <Link
                      to="/perfil"
                      className="block px-4 py-2.5 text-gray-700 hover:bg-emerald-50 transition-colors flex items-center space-x-2 text-sm"
                    >
                      <svg className="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                      </svg>
                      <span>Mi perfil</span>
                    </Link>
                    <button
                      onClick={handleLogout}
                      className="w-full text-left px-4 py-2.5 text-red-600 hover:bg-red-50 transition-colors flex items-center space-x-2 text-sm"
                    >
                      <svg className="w-4 h-4 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                      </svg>
                      <span>Cerrar sesión</span>
                    </button>
                  </div>
                </div>
              )}
            </div>
          </div>
        </div>
      </header>

      {/* Modales - FUERA del header */}
      {mostrarLoginModal && (
        <div className="fixed inset-0 z-[100]">
          <div 
            className="absolute inset-0 backdrop-blur-md bg-black/10"
            onClick={() => setMostrarLoginModal(false)}
          ></div>
          
          <div className="absolute inset-0 flex items-center justify-center p-4">
            <div 
              className="bg-white rounded-xl shadow-2xl max-w-md w-full border border-gray-200 relative z-10"
              onClick={(e) => e.stopPropagation()}
            >
              <LoginModal
                onClose={() => setMostrarLoginModal(false)}
                onOpenRegister={() => {
                  setMostrarLoginModal(false);
                  setMostrarRegisterModal(true);
                }}
              />
            </div>
          </div>
        </div>
      )}

      {mostrarRegisterModal && (
        <div className="fixed inset-0 z-[100]">
          <div 
            className="absolute inset-0 backdrop-blur-md bg-black/10"
            onClick={() => setMostrarRegisterModal(false)}
          ></div>
          
          <div className="absolute inset-0 flex items-center justify-center p-4">
            <div 
              className="bg-white rounded-xl shadow-2xl max-w-md w-full border border-gray-200 relative z-10"
              onClick={(e) => e.stopPropagation()}
            >
              <RegisterModal
                onClose={() => setMostrarRegisterModal(false)}
                onOpenLogin={() => {
                  setMostrarRegisterModal(false);
                  setMostrarLoginModal(true);
                }}
              />
            </div>
          </div>
        </div>
      )}
    </>
  );
}

export default Header;