import { useEffect, useState } from 'react';
import { IconChefHat, IconBook2, IconUsers } from '@tabler/icons-react';
import { UtensilsCrossed, UsersRound } from 'lucide-react';
import { FaRegLightbulb } from 'react-icons/fa';
import { motion } from 'framer-motion';
import { Modal, Tooltip, Badge } from '@mantine/core';

const cardVariants = {
  hidden: { opacity: 0, y: 40 },
  visible: (i: number) => ({ opacity: 1, y: 0, transition: { delay: i * 0.15, duration: 0.7, type: 'spring', stiffness: 80 } })
};

const HomePage = () => {
  const [opened, setOpened] = useState(true);
  // Función para scroll suave
  useEffect(() => {
    const handleSmoothScroll = (e: Event) => {
      const target = e.currentTarget as HTMLAnchorElement;
      const targetId = target.getAttribute('href');
      if (targetId && targetId.startsWith('#')) {
        e.preventDefault();
        const targetElement = document.querySelector(targetId);
        if (targetElement) {
          const headerHeight = document.querySelector('header')?.offsetHeight || 0;
          const targetPosition = targetElement.getBoundingClientRect().top + window.pageYOffset - headerHeight;
          window.scrollTo({
            top: targetPosition,
            behavior: 'smooth'
          });
        }
      }
    };
    // Aplicar a todos los enlaces internos
    const anchorElements = document.querySelectorAll('a[href^="#"]');
    anchorElements.forEach(anchor => {
      anchor.addEventListener('click', handleSmoothScroll);
    });
    return () => {
      anchorElements.forEach(anchor => {
        anchor.removeEventListener('click', handleSmoothScroll);
      });
    };
  }, []);

  return (
    <motion.div
      className="min-h-screen flex flex-col font-[Inter] bg-white"
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ duration: 0.7 }}
    >
      {/* Modal de bienvenida Mantine */}
      <Modal opened={opened} onClose={() => setOpened(false)} title="¡Bienvenido a NutriODS!" centered size="lg" radius="lg" overlayProps={{ blur: 2 }}>
        <div className="flex flex-col items-center gap-4 py-2">
          <FaRegLightbulb className="text-emerald-400 w-10 h-10 mb-2" />
          <p className="text-lg text-gray-700 font-medium text-center">Explora todas las funcionalidades, gráficos, animaciones y comunidad de NutriODS. ¡Disfruta la experiencia!</p>
        </div>
      </Modal>
      {/* Sección Hero - Versión Premium */}
      <motion.main
        className="relative isolate overflow-hidden flex-1"
        initial={{ opacity: 0, y: 40 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.8, type: 'spring', stiffness: 60 }}
      >
        {/* Fondo con gradiente superpuesto */}
        <div className="absolute h-[900px] inset-0 -z-10">
          <img
            src="https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=2960&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
            alt="Comida saludable estilo minimalista"
            className="w-full h-full object-cover object-center"
          />
          <div className="absolute inset-0 bg-gradient-to-t from-white-900/80 to-emerald-900/20 mix-blend-multiply" />
        </div>

        {/* Contenido principal */}
        <motion.div
          className="relative max-w-7xl mx-auto px-6 py-32 sm:py-36 lg:py-40 lg:px-8 flex flex-col items-center justify-center h-full text-center"
          initial={{ opacity: 0, y: 40 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2, duration: 0.8, type: 'spring', stiffness: 60 }}
        >
          <div className="max-w-3xl space-y-10">
            {/* Elemento decorativo */}
            <motion.div
              className="inline-flex items-center justify-center px-6 py-2 rounded-full bg-emerald-200/20 backdrop-blur-sm border border-emerald-200/40 mb-6 gap-2"
              initial={{ opacity: 0, scale: 0.8 }}
              animate={{ opacity: 1, scale: 1 }}
              transition={{ delay: 0.4, duration: 0.7, type: 'spring', stiffness: 80 }}
            >
              <FaRegLightbulb className="text-emerald-400 w-5 h-5" />
              <span className="text-base font-semibold text-emerald-900 tracking-widest uppercase">BIENVENIDO 2024</span>
            </motion.div>

            {/* Título principal */}
            <motion.h1
              className="text-5xl md:text-6xl lg:text-7xl font-extrabold tracking-tight text-white leading-tight"
              initial={{ opacity: 0, y: 30 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.5, duration: 0.7, type: 'spring', stiffness: 80 }}
            >
              Bienvenido a <span className="text-emerald-300">NutriODS</span>
            </motion.h1>

            {/* Subtítulo */}
            <motion.p
              className="text-2xl md:text-3xl text-emerald-50/90 leading-relaxed max-w-2xl mx-auto font-medium"
              initial={{ opacity: 0, y: 30 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.6, duration: 0.7, type: 'spring', stiffness: 80 }}
            >
              Tu plataforma de recetas, dietas y hábitos saludables para alcanzar tu mejor versión.
            </motion.p>

            {/* CTA */}
            <motion.div
              className="flex flex-col sm:flex-row gap-4 justify-center pt-6"
              initial={{ opacity: 0, y: 30 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.7, duration: 0.7, type: 'spring', stiffness: 80 }}
            >
              <Tooltip label="Descubre todas las funciones" color="teal" withArrow>
                <motion.a
                  href="#funcionalidades"
                  className="px-8 py-4 rounded-full bg-emerald-600 hover:bg-emerald-500 text-white font-semibold shadow-lg shadow-emerald-600/20 hover:shadow-emerald-500/30 transition-all duration-300 transform hover:-translate-y-1 text-lg flex items-center gap-3"
                  whileHover={{ scale: 1.07 }}
                  whileTap={{ scale: 0.97 }}
                >
                  <IconChefHat className="w-6 h-6" /> Ver Funcionalidades
                </motion.a>
              </Tooltip>
              <Tooltip label="Crea tu cuenta gratis" color="teal" withArrow>
                <motion.a
                  href="#registro"
                  className="px-8 py-4 rounded-full bg-white/10 hover:bg-white/20 text-white font-semibold backdrop-blur-sm border border-white/20 transition-all duration-300 text-lg flex items-center gap-3"
                  whileHover={{ scale: 1.07 }}
                  whileTap={{ scale: 0.97 }}
                >
                  <IconUsers className="w-6 h-6" /> Registrarse
                </motion.a>
              </Tooltip>
            </motion.div>
          </div>

          {/* Indicador scroll */}
          <motion.div
            className="absolute bottom-10 left-1/2 -translate-x-1/2 animate-bounce"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 1, duration: 0.7 }}
          >
            <svg className="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M19 14l-7 7m0 0l-7-7m7 7V3"></path>
            </svg>
          </motion.div>
        </motion.div>
      </motion.main>

      {/* Sección de Funcionalidades */}
      <section id="funcionalidades" className="bg-gradient-to-b from-white to-[#f8faf7] py-20 px-4">
        <div className="max-w-6xl mx-auto text-center">
          <motion.div
            className="mb-16"
            initial={{ opacity: 0, y: 40 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.8, type: 'spring', stiffness: 60 }}
          >
            <h2 className="text-4xl md:text-5xl font-extrabold text-gray-900 mb-4 leading-tight">
              Descubre Nutri<span className="text-emerald-500">ODS</span>
            </h2>
            <p className="text-gray-500 max-w-2xl mx-auto text-xl font-medium">
              Herramientas inteligentes para transformar tu relación con la alimentación
            </p>
          </motion.div>

              initial="hidden"
              whileInView="visible"
              viewport={{ once: true }}
              custom={0}
            >
              <Badge color="teal" size="lg" radius="md" className="mb-2">¡Nuevo!</Badge>
              <Tooltip label="Dietas personalizadas para ti" color="teal" withArrow>
                <div className="w-16 h-16 bg-emerald-50 rounded-lg flex items-center justify-center mb-5 group-hover:bg-emerald-100 transition-colors mx-auto">
                  <IconChefHat className="w-8 h-8 text-emerald-600" />
                </div>
              </Tooltip>
              <h3 className="text-2xl font-semibold text-gray-800 mb-3">Dietas Personalizadas</h3>
              <p className="text-gray-500 leading-relaxed text-base">
                Planes nutricionales adaptados a tus metas, preferencias y estilo de vida.
              </p>
            </motion.div>
            {/* Tarjeta 2 */}
            <motion.div
              className="bg-white p-8 rounded-2xl shadow-md hover:shadow-xl transition-all duration-300 border border-gray-100 hover:border-emerald-100 group text-center"
              variants={cardVariants}
              initial="hidden"
              whileInView="visible"
              viewport={{ once: true }}
              custom={1}
            >
              <Badge color="yellow" size="lg" radius="md" className="mb-2">Top recetas</Badge>
              <Tooltip label="Recetas creativas y saludables" color="teal" withArrow>
                <div className="w-16 h-16 bg-emerald-50 rounded-lg flex items-center justify-center mb-5 group-hover:bg-emerald-100 transition-colors mx-auto">
                  <UtensilsCrossed className="w-8 h-8 text-emerald-600" />
                </div>
              </Tooltip>
              <h3 className="text-2xl font-semibold text-gray-800 mb-3">Recetas Creativas</h3>
              <p className="text-gray-500 leading-relaxed text-base">
                Inspiración culinaria saludable para cada temporada y ocasión.
              </p>
            </motion.div>
            {/* Tarjeta 3 */}
            <motion.div
              className="bg-white p-8 rounded-2xl shadow-md hover:shadow-xl transition-all duration-300 border border-gray-100 hover:border-emerald-100 group text-center"
              variants={cardVariants}
              initial="hidden"
              whileInView="visible"
              viewport={{ once: true }}
              custom={2}
            >
              <Badge color="grape" size="lg" radius="md" className="mb-2">Comunidad</Badge>
              <Tooltip label="Únete a la comunidad" color="teal" withArrow>
                <div className="w-16 h-16 bg-emerald-50 rounded-lg flex items-center justify-center mb-5 group-hover:bg-emerald-100 transition-colors mx-auto">
                  <UsersRound className="w-8 h-8 text-emerald-600" />
                </div>
              </Tooltip>
              <h3 className="text-2xl font-semibold text-gray-800 mb-3">Comunidad Activa</h3>
              <p className="text-gray-500 leading-relaxed text-base">
                Conecta con personas que comparten tu interés por el bienestar.
              </p>
            </motion.div>
            {/* Tarjeta 4 */}
            <motion.div
              className="bg-white p-8 rounded-2xl shadow-md hover:shadow-xl transition-all duration-300 border border-gray-100 hover:border-emerald-100 group text-center"
              variants={cardVariants}
              initial="hidden"
              whileInView="visible"
              viewport={{ once: true }}
              custom={3}
            >
              <Badge color="cyan" size="lg" radius="md" className="mb-2">Aprende</Badge>
              <Tooltip label="Recursos de aprendizaje continuo" color="teal" withArrow>
                <div className="w-16 h-16 bg-emerald-50 rounded-lg flex items-center justify-center mb-5 group-hover:bg-emerald-100 transition-colors mx-auto">
                  <IconBook2 className="w-8 h-8 text-emerald-600" />
                </div>
              </Tooltip>
              <h3 className="text-2xl font-semibold text-gray-800 mb-3">Aprendizaje Continuo</h3>
              <p className="text-gray-500 leading-relaxed text-base">
                Recursos basados en evidencia para una nutrición consciente.
              </p>
            </motion.div>
          </div>
        </div>
      </section>
    </motion.div>
  );
};

export default HomePage;