import logo from "../assets/logo.png";

function Footer() {
  return (
    <footer className="bg-green-600 text-white py-6">
      <div className="flex flex-col items-center space-y-4">
        {/* Logo */}
        <div>
         <img src={logo} alt="Logo NutriODS" className="h-24 w-auto" />
        </div>

        {/* Links de navegación */}
        <nav className="flex space-x-6 text-sm font-medium">
          <a
            href="#generar-dieta"
            className="hover:text-green-800 transition"
          >
            Generar Dieta
          </a>
          <a
            href="#recetas"
            className="hover:text-green-300 transition"
          >
            Recetas
          </a>
          <a
            href="#foro"
            className="hover:text-green-300 transition"
          >
            Foro
          </a>
          <a
            href="#educacion"
            className="hover:text-green-300 transition"
          >
            Educación
          </a>
        </nav>

        {/* Mensaje de derechos de autor */}
        <div className="text-xs text-gray-300">
          © 2025 NutriODS - Todos los derechos reservados
        </div>
      </div>
    </footer>
  );
}

export default Footer;