import { useEffect } from 'react';

const HomePage = () => {
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
    <div className="min-h-screen flex flex-col">
      {/* Sección Hero - Versión Premium */}
      <main className="relative isolate overflow-hidden flex-1">
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
        <div className="relative max-w-7xl mx-auto px-6 py-26 sm:py-26 lg:py-32 lg:px-8 flex flex-col items-center justify-center h-full text-center">
          <div className="max-w-3xl space-y-8">
            {/* Elemento decorativo */}
            <div className="inline-flex items-center justify-center px-6 py-2 rounded-full bg-emerald-100/10 backdrop-blur-sm border border-emerald-100/20 mb-6">
              <span className="text-sm font-medium text-emerald-100">BIENVENIDO 2024</span>
            </div>

            {/* Título principal */}
            <h1 className="text-5xl md:text-6xl lg:text-7xl font-serif font-bold tracking-tight text-white">
              Bienvenido a <span className="text-emerald-300">NutriODS</span>
            </h1>

            {/* Subtítulo */}
            <p className="text-xl md:text-2xl text-emerald-50/90 leading-relaxed max-w-2xl mx-auto">
              Tu plataforma de recetas, dietas y hábitos saludables para alcanzar tu mejor versión.
            </p>

            {/* CTA */}
            <div className="flex flex-col sm:flex-row gap-4 justify-center pt-6">
              <a
                href="#funcionalidades"
                className="px-8 py-4 rounded-full bg-emerald-600 hover:bg-emerald-500 text-white font-medium shadow-lg shadow-emerald-600/20 hover:shadow-emerald-500/30 transition-all duration-300 transform hover:-translate-y-1"
              >
                Ver Funcionalidades
              </a>
              <a
                href="#registro"
                className="px-8 py-4 rounded-full bg-white/10 hover:bg-white/20 text-white font-medium backdrop-blur-sm border border-white/20 transition-all duration-300"
              >
                Registrarse
              </a>
            </div>
          </div>

          {/* Indicador scroll */}
          <div className="absolute bottom-10 left-1/2 -translate-x-1/2 animate-bounce">
            <svg className="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M19 14l-7 7m0 0l-7-7m7 7V3"></path>
            </svg>
          </div>
        </div>
      </main>

      {/* Sección de Funcionalidades */}
      <section id="funcionalidades" className="bg-gradient-to-b from-white to-[#f8faf7] py-16 px-4">
        <div className="max-w-6xl mx-auto text-center">
          <div className="mb-12">
            <h2 className="text-4xl font-serif font-semibold text-gray-900 mb-4">
              Descubre Nutri<span className="text-emerald-500">ODS</span>
            </h2>
            <p className="text-gray-500 max-w-2xl mx-auto text-lg">
              Herramientas inteligentes para transformar tu relación con la alimentación
            </p>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {/* Tarjeta 1 */}
            <div className="bg-white p-8 rounded-xl shadow-sm hover:shadow-md transition-all duration-300 border border-gray-100 hover:border-emerald-100 group text-center">
              <div className="w-14 h-14 bg-emerald-50 rounded-lg flex items-center justify-center mb-5 group-hover:bg-emerald-100 transition-colors mx-auto">
                <svg className="w-6 h-6 text-emerald-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"></path>
                </svg>
              </div>
              <h3 className="text-xl font-semibold text-gray-800 mb-3">Dietas Personalizadas</h3>
              <p className="text-gray-500 leading-relaxed">
                Planes nutricionales adaptados a tus metas, preferencias y estilo de vida.
              </p>
            </div>

            {/* Tarjeta 2 */}
            <div className="bg-white p-8 rounded-xl shadow-sm hover:shadow-md transition-all duration-300 border border-gray-100 hover:border-emerald-100 group text-center">
              <div className="w-14 h-14 bg-emerald-50 rounded-lg flex items-center justify-center mb-5 group-hover:bg-emerald-100 transition-colors mx-auto">
                <svg className="w-6 h-6 text-emerald-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                </svg>
              </div>
              <h3 className="text-xl font-semibold text-gray-800 mb-3">Recetas Creativas</h3>
              <p className="text-gray-500 leading-relaxed">
                Inspiración culinaria saludable para cada temporada y ocasión.
              </p>
            </div>

            {/* Tarjeta 3 */}
            <div className="bg-white p-8 rounded-xl shadow-sm hover:shadow-md transition-all duration-300 border border-gray-100 hover:border-emerald-100 group text-center">
              <div className="w-14 h-14 bg-emerald-50 rounded-lg flex items-center justify-center mb-5 group-hover:bg-emerald-100 transition-colors mx-auto">
                <svg className="w-6 h-6 text-emerald-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                </svg>
              </div>
              <h3 className="text-xl font-semibold text-gray-800 mb-3">Comunidad Activa</h3>
              <p className="text-gray-500 leading-relaxed">
                Conecta con personas que comparten tu interés por el bienestar.
              </p>
            </div>

            {/* Tarjeta 4 */}
            <div className="bg-white p-8 rounded-xl shadow-sm hover:shadow-md transition-all duration-300 border border-gray-100 hover:border-emerald-100 group text-center">
              <div className="w-14 h-14 bg-emerald-50 rounded-lg flex items-center justify-center mb-5 group-hover:bg-emerald-100 transition-colors mx-auto">
                <svg className="w-6 h-6 text-emerald-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"></path>
                </svg>
              </div>
              <h3 className="text-xl font-semibold text-gray-800 mb-3">Aprendizaje Continuo</h3>
              <p className="text-gray-500 leading-relaxed">
                Recursos basados en evidencia para una nutrición consciente.
              </p>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
};

export default HomePage;