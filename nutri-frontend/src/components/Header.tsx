import logo from "../assets/logo.png";

function Header() {

  return (
    <header className="relative w-full h-30 bg-white shadow-sm">
      {/* Logo absoluto, centrado arriba */}
      <div className="absolute top-0 left-1/2 transform -translate-x-1/2 pt-4">
        <img src={logo} alt="Logo BioNut" className="h-24 w-auto" />
      </div>

      {/* Contenedor inferior con nav izquierda y botones derecha */}
      <div className="absolute bottom-2 left-0 right-0 flex justify-between items-center px-6">
        {/* Nav a la izquierda */}
        <nav className="flex space-x-6 text-gray-700 font-medium">
          <a href="#" className="hover:text-green-600">Generar Dieta</a>
          <a href="#" className="hover:text-green-600">Recetas</a>
          <a href="#" className="hover:text-green-600">Foro</a>
          <a href="#" className="hover:text-green-600">Educación</a>
        </nav>

        {/* Botones a la derecha */}
        <div className="flex items-center space-x-4">
          <button className="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-lg font-semibold"
          >
            Iniciar sesión
          </button>
        </div>
      </div>
    </header>
  );
}

export default Header;
