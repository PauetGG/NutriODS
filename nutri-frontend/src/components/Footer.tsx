import logo from "../assets/logo.png";
import { Link } from "react-router-dom";

function Footer() {
  return (
    <footer className="relative w-full bg-white pb-6 pt-6 mt-10">
      {/* Logo centrado */}
      <div className="absolute top-0 left-1/2 transform -translate-x-1/2 -translate-y-1/2">
        <Link
          to="/"
          onClick={() => window.scrollTo({ top: 0, behavior: "smooth" })}
        >
          <div className="border-2 border-black rounded-full p-3 bg-white cursor-pointer mt-7">
            <img src={logo} alt="Logo NutriODS" className="h-16 w-auto" />
          </div>
        </Link>
      </div>

      {/* Contenido del footer */}
      <div className="flex flex-col items-center justify-center space-y-4 mt-12">
        {/* Links de navegación */}
        <nav className="flex space-x-6 text-gray-700 font-medium">
          <Link to="/dieta" className="hover:text-green-600 transition">Generar Dieta</Link>
          <Link to="/recetas" className="hover:text-green-600 transition">Recetas</Link>
          <Link to="/foro" className="hover:text-green-600 transition">Foro</Link>
          <Link to="/articulo" className="hover:text-green-600 transition">Educación</Link>
        </nav>
        {/* Mensaje de derechos de autor */}
        <div className="text-xs text-gray-400 text-center">
          © 2025 BioNut - Todos los derechos reservados
        </div>
      </div>
    </footer>
  );
}

export default Footer;
