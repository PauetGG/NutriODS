function EstadisticasPage() {
  return (
    <div className="max-w-3xl mx-auto p-6 pt-16">
      <h1 className="text-3xl font-bold mb-6 text-center text-blue-800">Tus estadísticas</h1>

      {/* FÍSICAS */}
      <details open className="mb-4 border rounded-lg">
        <summary className="cursor-pointer bg-gray-100 px-4 py-2 font-semibold text-lg">🏋️ Estadísticas físicas</summary>
        <div className="p-4 space-y-3 text-gray-700">
          <p>Peso actual: <strong>72 kg</strong></p>
          <p>Altura: <strong>1.75 m</strong></p>
          <p>Horas de sueño: <strong>7</strong></p>
          <p>Calidad del sueño: <strong>4/5</strong></p>
          <p>Ejercicio físico: <strong>Sí (Fuerza)</strong></p>
          <p>Pasos diarios: <strong>8600</strong></p>
          <p>Litros de agua: <strong>1.8 L</strong></p>
        </div>
      </details>

      {/* MENTALES */}
      <details className="mb-4 border rounded-lg">
        <summary className="cursor-pointer bg-gray-100 px-4 py-2 font-semibold text-lg">🧠 Estadísticas mentales</summary>
        <div className="p-4 space-y-3 text-gray-700">
          <p>Nivel de energía: <strong>3/5</strong></p>
          <p>Estrés: <strong>2/5</strong></p>
          <p>Calidad del descanso: <strong>4/5</strong></p>
        </div>
      </details>

      {/* ANÍMICAS */}
      <details className="mb-4 border rounded-lg">
        <summary className="cursor-pointer bg-gray-100 px-4 py-2 font-semibold text-lg">💖 Estadísticas anímicas</summary>
        <div className="p-4 space-y-3 text-gray-700">
          <p>Estado de ánimo: <strong>Feliz</strong></p>
          <p>Motivación: <strong>4/5</strong></p>
        </div>
      </details>

      {/* NUTRITIVAS */}
      <details className="mb-4 border rounded-lg">
        <summary className="cursor-pointer bg-gray-100 px-4 py-2 font-semibold text-lg">🥗 Estadísticas nutritivas</summary>
        <div className="p-4 space-y-3 text-gray-700">
          <p>Comidas completadas: <strong>4 de 5</strong></p>
          <p>Calorías consumidas: <strong>1800 kcal</strong></p>
          <p>Notas: <strong>Desayuno fuera de casa</strong></p>
        </div>
      </details>
    </div>
  );
}

export default EstadisticasPage;
