import logo from "../assets/logo.png";
import { Link } from "react-router-dom";
import { IconHome, IconBook2, IconList, IconWorld, IconUsers, IconChefHat, IconMessageCircle2 } from '@tabler/icons-react';
import { motion } from 'framer-motion';

const auraVariants = {
  animate: {
    boxShadow: [
      "0 0 60px 10px #6ee7b7, 0 0 120px 20px #059669",
      "0 0 80px 20px #059669, 0 0 160px 40px #6ee7b7",
      "0 0 60px 10px #6ee7b7, 0 0 120px 20px #059669"
    ],
    transition: {
      duration: 4,
      repeat: Infinity,
      ease: "easeInOut"
    }
  }
};

function Footer() {
  return (
    <motion.footer
      className="relative w-full bg-gradient-to-br from-emerald-400 via-emerald-500 to-emerald-700 text-white border-t border-emerald-700 pb-10 pt-14 mt-20 overflow-hidden shadow-2xl rounded-t-3xl font-[Inter]"
      variants={auraVariants}
      animate="animate"
      style={{ position: 'relative', zIndex: 1 }}
    >
      <div className="container mx-auto px-6">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-12 max-w-6xl mx-auto items-center">
          {/* Columna 1 - Descripción */}
          <div className="flex flex-col items-center md:items-start text-center md:text-left justify-center gap-3">
            <h2 className="text-4xl font-extrabold mb-2 tracking-tight text-white drop-shadow-lg">BioNut</h2>
            <p className="text-white/90 text-lg leading-relaxed max-w-md font-medium drop-shadow">
              Transformando hábitos alimenticios con tecnología y nutrición basada en evidencia.<br/>
              <span className="font-bold text-emerald-100">¡Únete a nuestra comunidad saludable!</span>
            </p>
          </div>

          {/* Columna 2 - Logo centrado con aura animada */}
          <div className="flex flex-col items-center justify-center w-full">
            <button
              onClick={() => window.scrollTo({ top: 0, behavior: "smooth" })}
              className="focus:outline-none group"
              style={{ background: 'none', border: 'none', padding: 0 }}
              aria-label="Ir arriba"
            >
              <motion.div
                className="rounded-full bg-white p-6 shadow-2xl border-4 border-emerald-400 flex items-center justify-center mx-auto transition-transform duration-300 group-hover:scale-105"
                style={{ width: 140, height: 140, marginBottom: 8 }}
                initial={{ boxShadow: "0 0 60px 10px #6ee7b7, 0 0 120px 20px #059669" }}
                animate={{
                  boxShadow: [
                    "0 0 60px 10px #6ee7b7, 0 0 120px 20px #059669",
                    "0 0 80px 20px #059669, 0 0 160px 40px #6ee7b7",
                    "0 0 60px 10px #6ee7b7, 0 0 120px 20px #059669"
                  ]
                }}
                transition={{ duration: 4, repeat: Infinity, ease: "easeInOut" }}
              >
                <img 
                  src={logo} 
                  alt="Logo BioNut" 
                  className="h-28 w-28 object-contain drop-shadow-xl" 
                  style={{ display: 'block', margin: '0 auto' }}
                />
              </motion.div>
            </button>
          </div>

          {/* Columna 3 - Navegación */}
          <div className="flex flex-col items-center md:items-end justify-center gap-2">
            <h3 className="text-2xl font-bold uppercase tracking-wider mb-4 flex items-center gap-2 text-emerald-100 drop-shadow">
              <IconHome size={28} className="text-emerald-200" /> Navegación
            </h3>
            <nav className="grid grid-cols-2 gap-x-8 gap-y-4 text-lg">
              <Link to="/dieta" className="flex items-center gap-2 hover:text-emerald-200 transition-colors font-semibold group">
                <IconChefHat size={22} className="transition-transform group-hover:-translate-y-1" /> Generar Dieta
              </Link>
              <Link to="/recetas" className="flex items-center gap-2 hover:text-emerald-200 transition-colors font-semibold group">
                <IconBook2 size={22} className="transition-transform group-hover:-translate-y-1" /> Recetas
              </Link>
              <Link to="/articulos" className="flex items-center gap-2 hover:text-emerald-200 transition-colors font-semibold group">
                <IconList size={22} className="transition-transform group-hover:-translate-y-1" /> Artículos
              </Link>
              <Link to="/glosario" className="flex items-center gap-2 hover:text-emerald-200 transition-colors font-semibold group">
                <IconWorld size={22} className="transition-transform group-hover:-translate-y-1" /> Glosario
              </Link>
              <Link to="/foro" className="flex items-center gap-2 hover:text-emerald-200 transition-colors font-semibold group">
                <IconMessageCircle2 size={22} className="transition-transform group-hover:-translate-y-1" /> Comunidad
              </Link>
              <Link to="/multimedia" className="flex items-center gap-2 hover:text-emerald-200 transition-colors font-semibold group">
                <IconUsers size={22} className="transition-transform group-hover:-translate-y-1" /> Recursos
              </Link>
            </nav>
          </div>
        </div>

        {/* Divider */}
        <div className="my-10 border-t border-emerald-200/40"></div>

        {/* Bottom section */}
        <div className="flex flex-col md:flex-row justify-between items-center gap-4">
          <div className="text-base text-emerald-100 font-medium drop-shadow">
            © {new Date().getFullYear()} BioNut. Todos los derechos reservados.
          </div>
        </div>
      </div>
    </motion.footer>
  );
}

export default Footer;
