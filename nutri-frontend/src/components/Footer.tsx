import logo from "../assets/logo.png";
import { Link } from "react-router-dom";

function Footer() {
  return (
    <footer className="relative w-full bg-gradient-to-b from-white to-gray-50 border-t border-gray-100 pb-12 pt-16 mt-20">
  {/* Logo flotante con efecto hover */}
  <div className="absolute top-0 left-1/2 transform -translate-x-1/2 -translate-y-1/2">
    <Link
      to="/"
      onClick={() => window.scrollTo({ top: 0, behavior: "smooth" })}
      className="group"
    >
      <div className="border-2 border-emerald-400 rounded-full p-2 bg-white shadow-lg hover:shadow-emerald-200/50 transition-all duration-300 group-hover:scale-110 group-hover:border-emerald-500">
        <img 
          src={logo} 
          alt="Logo NutriODS" 
          className="h-14 w-auto transition-transform duration-300 group-hover:rotate-6" 
        />
      </div>
    </Link>
  </div>

  {/* Contenido principal del footer */}
  <div className="container mx-auto px-6">
    {/* Grid de contenido */}
    <div className="grid grid-cols-1 md:grid-cols-4 gap-8 max-w-6xl mx-auto">
      {/* Columna 1 - Logo y descripción */}
      <div className="md:col-span-2 flex flex-col items-center md:items-start">
        <div className="mb-4">
          <img src={logo} alt="NutriODS" className="h-10 w-auto opacity-90" />
        </div>
        <p className="text-gray-500 text-sm leading-relaxed text-center md:text-left max-w-md">
          Transformando hábitos alimenticios con tecnología y nutrición basada en evidencia.
        </p>
      </div>

      {/* Columna 2 - Navegación */}
      <div className="flex flex-col items-center md:items-start">
        <h3 className="text-sm font-semibold text-gray-900 uppercase tracking-wider mb-4">Navegación</h3>
        <nav className="flex flex-col space-y-2">
          <Link 
            to="/dieta" 
            className="text-gray-500 hover:text-emerald-600 transition-colors duration-200 text-sm"
          >
            Generar Dieta
          </Link>
          <Link 
            to="/recetas" 
            className="text-gray-500 hover:text-emerald-600 transition-colors duration-200 text-sm"
          >
            Recetas Saludables
          </Link>
          <Link 
            to="/foro" 
            className="text-gray-500 hover:text-emerald-600 transition-colors duration-200 text-sm"
          >
            Comunidad
          </Link>
        </nav>
      </div>

      {/* Columna 3 - Legal */}
      <div className="flex flex-col items-center md:items-start">
        <h3 className="text-sm font-semibold text-gray-900 uppercase tracking-wider mb-4">Legal</h3>
        <nav className="flex flex-col space-y-2">
          <Link 
            to="/privacidad" 
            className="text-gray-500 hover:text-emerald-600 transition-colors duration-200 text-sm"
          >
            Política de Privacidad
          </Link>
          <Link 
            to="/terminos" 
            className="text-gray-500 hover:text-emerald-600 transition-colors duration-200 text-sm"
          >
            Términos de Servicio
          </Link>
          <Link 
            to="/cookies" 
            className="text-gray-500 hover:text-emerald-600 transition-colors duration-200 text-sm"
          >
            Cookies
          </Link>
        </nav>
      </div>
    </div>

    {/* Divider */}
    <div className="my-8 border-t border-gray-200"></div>

    {/* Bottom section */}
    <div className="flex flex-col md:flex-row justify-between items-center">
      {/* Derechos de autor */}
      <div className="text-xs text-gray-400 mb-4 md:mb-0">
        © {new Date().getFullYear()} NutriODS. Todos los derechos reservados.
      </div>

      {/* Redes sociales */}
      <div className="flex space-x-4">
        <a href="#" className="text-gray-400 hover:text-emerald-500 transition-colors">
          <span className="sr-only">Facebook</span>
          <svg className="h-5 w-5" fill="currentColor" viewBox="0 0 24 24">
            <path fillRule="evenodd" d="M22 12c0-5.523-4.477-10-10-10S2 6.477 2 12c0 4.991 3.657 9.128 8.438 9.878v-6.987h-2.54V12h2.54V9.797c0-2.506 1.492-3.89 3.777-3.89 1.094 0 2.238.195 2.238.195v2.46h-1.26c-1.243 0-1.63.771-1.63 1.562V12h2.773l-.443 2.89h-2.33v6.988C18.343 21.128 22 16.991 22 12z" clipRule="evenodd" />
          </svg>
        </a>
        <a href="#" className="text-gray-400 hover:text-emerald-500 transition-colors">
          <span className="sr-only">Instagram</span>
          <svg className="h-5 w-5" fill="currentColor" viewBox="0 0 24 24">
            <path fillRule="evenodd" d="M12.315 2c2.43 0 2.784.013 3.808.06 1.064.049 1.791.218 2.427.465a4.902 4.902 0 011.772 1.153 4.902 4.902 0 011.153 1.772c.247.636.416 1.363.465 2.427.048 1.067.06 1.407.06 4.123v.08c0 2.643-.012 2.987-.06 4.043-.049 1.064-.218 1.791-.465 2.427a4.902 4.902 0 01-1.153 1.772 4.902 4.902 0 01-1.772 1.153c-.636.247-1.363.416-2.427.465-1.067.048-1.407.06-4.123.06h-.08c-2.643 0-2.987-.012-4.043-.06-1.064-.049-1.791-.218-2.427-.465a4.902 4.902 0 01-1.772-1.153 4.902 4.902 0 01-1.153-1.772c-.247-.636-.416-1.363-.465-2.427-.047-1.024-.06-1.379-.06-3.808v-.63c0-2.43.013-2.784.06-3.808.049-1.064.218-1.791.465-2.427a4.902 4.902 0 011.153-1.772A4.902 4.902 0 015.45 2.525c.636-.247 1.363-.416 2.427-.465C8.901 2.013 9.256 2 11.685 2h.63zm-.081 1.802h-.468c-2.456 0-2.784.011-3.807.058-.975.045-1.504.207-1.857.344-.467.182-.8.398-1.15.748-.35.35-.566.683-.748 1.15-.137.353-.3.882-.344 1.857-.047 1.023-.058 1.351-.058 3.807v.468c0 2.456.011 2.784.058 3.807.045.975.207 1.504.344 1.857.182.466.399.8.748 1.15.35.35.683.566 1.15.748 1.857.344.353.3.882.344 1.857.047 1.023.058 1.351.058 3.807v.468c0 2.456-.011 2.784-.058 3.807-.045.975-.207 1.504-.344 1.857-.182.466-.399.8-.748 1.15-.35.35-.683.566-1.15.748-.353.137-.882.3-1.857.344-1.054.048-1.37.058-4.041.058h-.08c-2.597 0-2.917-.01-3.96-.058-.975-.045-1.504-.207-1.857-.344-.467-.182-.8-.398-1.15-.748-.35-.35-.566-.683-.748-1.15-.137-.353-.3-.882-.344-1.857-.048-1.054-.058-1.37-.058-4.041v-.08c0-2.597.01-2.917.058-3.96.045-.975.207-1.504.344-1.857.182-.467.398-.8.748-1.15.35-.35.683-.566 1.15-.748.353-.137.882-.3 1.857-.344 1.023-.047 1.351-.058 3.807-.058h.468c2.456 0 2.784-.011 3.807-.058.975-.045 1.504-.207 1.857-.344.466-.182.8-.398 1.15-.748.35-.35.566-.683.748-1.15.137-.353.3-.882.344-1.857.048-1.023.058-1.351.058-3.807v-.468c0-2.456-.011-2.784-.058-3.807-.045-.975-.207-1.504-.344-1.857a3.097 3.097 0 00-.748-1.15 3.098 3.098 0 00-1.15-.748c-.353-.137-.882-.3-1.857-.344-1.023-.047-1.351-.058-3.807-.058zM12 6.865a5.135 5.135 0 110 10.27 5.135 5.135 0 010-10.27zm0 1.802a3.333 3.333 0 100 6.666 3.333 3.333 0 000-6.666zm5.338-3.205a1.2 1.2 0 110 2.4 1.2 1.2 0 010-2.4z" clipRule="evenodd" />
          </svg>
        </a>
        <a href="#" className="text-gray-400 hover:text-emerald-500 transition-colors">
          <span className="sr-only">Twitter</span>
          <svg className="h-5 w-5" fill="currentColor" viewBox="0 0 24 24">
            <path d="M8.29 20.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0022 5.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.072 4.072 0 012.8 9.713v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 012 18.407a11.616 11.616 0 006.29 1.84" />
          </svg>
        </a>
      </div>
    </div>
  </div>
</footer>
  );
}

export default Footer;
