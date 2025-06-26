const HomePage = () => {
  return (
    <div className="min-h-screen flex flex-col">
      {/* Sección Hero */}
      <main className="relative flex flex-col items-center justify-center text-center flex-1">
        <div className="absolute inset-0">
          <img
            src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1600&q=80"
            alt="Fondo saludable"
            className="w-full h-full object-cover opacity-60"
          />
        </div>
        <div className="relative z-10 p-6">
          <h1 className="text-5xl font-bold text-white drop-shadow-lg">
            Bienvenido a NutriODS
          </h1>
          <p className="text-xl text-white drop-shadow-md mt-4 max-w-2xl mx-auto">
            Tu plataforma de recetas, dietas y hábitos saludables para alcanzar tu mejor versión.
          </p>
          <div className="mt-8">
            <a
              href="#funcionalidades"
              className="bg-green-600 hover:bg-green-700 text-white font-bold py-3 px-8 rounded-full shadow-lg"
            >
              Ver Funcionalidades
            </a>
          </div>
        </div>
      </main>

      {/* Sección de Funcionalidades */}
      <section id="funcionalidades" className="bg-gray-100 py-12">
        <div className="max-w-6xl mx-auto text-center">
          <h2 className="text-3xl font-bold text-green-800">¿Qué encontrarás en NutriODS?</h2>
          <p className="text-gray-600 mt-4">
            Una experiencia pensada para ayudarte a alcanzar tu objetivo de alimentación y hábitos saludables.
          </p>

          <div className="mt-10 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-8 px-6">
            <div className="bg-white rounded-lg shadow-lg p-6 hover:shadow-2xl transition cursor-pointer">
              <h3 className="text-xl font-bold text-green-700">Generador de Dietas</h3>
              <p className="text-gray-600 mt-2">
                Crea planes adaptados a tu necesidad y objetivo en segundos.
              </p>
            </div>
            <div className="bg-white rounded-lg shadow-lg p-6 hover:shadow-2xl transition cursor-pointer">
              <h3 className="text-xl font-bold text-green-700">Recetas Saludables</h3>
              <p className="text-gray-600 mt-2">
                Explora recetas para todas las estaciones y adaptadas a tu dieta.
              </p>
            </div>
            <div className="bg-white rounded-lg shadow-lg p-6 hover:shadow-2xl transition cursor-pointer">
              <h3 className="text-xl font-bold text-green-700">Foro y Comunidad</h3>
              <p className="text-gray-600 mt-2">
                Comparte consejos y experiencias para mantener hábitos saludables.
              </p>
            </div>
            <div className="bg-white rounded-lg shadow-lg p-6 hover:shadow-2xl transition cursor-pointer">
              <h3 className="text-xl font-bold text-green-700">Recursos Educativos</h3>
              <p className="text-gray-600 mt-2">
                Aprende sobre alimentación, hábitos y nutrición sostenible.
              </p>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
};

export default HomePage;
