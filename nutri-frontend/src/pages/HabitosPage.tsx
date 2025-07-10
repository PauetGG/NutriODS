import { useState } from "react";

function HabitosPage() {
  const [agua, setAgua] = useState<number>(0);
  const [suenoHoras, setSuenoHoras] = useState<number>(8);
  const [calidadSueno, setCalidadSueno] = useState<number>(3);
  const [pasos, setPasos] = useState<number>(0);
  const [animo, setAnimo] = useState<number>(3);
  const [estres, setEstres] = useState<number>(3);
  const [motivacion, setMotivacion] = useState<number>(3);
  const [aireLibre, setAireLibre] = useState<number>(0);
  const [pantallas, setPantallas] = useState<number>(0);
  const [reflexion, setReflexion] = useState<string>("");

  const handleGuardar = (e: React.FormEvent) => {
    e.preventDefault();

    const datos = {
      fecha: new Date().toISOString().split("T")[0],
      agua,
      suenoHoras,
      calidadSueno,
      pasos,
      animo,
      estres,
      motivacion,
      aireLibre,
      pantallas,
      reflexion,
    };

    console.log("Datos guardados:", datos);
    alert("Hábitos guardados correctamente");
    // Aquí irá el POST al backend más adelante
  };

  return (
    <div className="p-6 bg-gray-100 min-h-screen">
      <h2 className="text-2xl font-bold text-center text-blue-800 mb-6">
        Registro de hábitos diarios
      </h2>

      <form
        onSubmit={handleGuardar}
        className="max-w-3xl mx-auto bg-white border border-blue-300 shadow-xl p-6 rounded-xl grid grid-cols-1 md:grid-cols-2 gap-6"
      >
        {/* Agua */}
        <div>
          <label className="block text-sm font-medium mb-1">Litros de agua</label>
          <input
            type="number"
            step="0.1"
            min={0}
            value={agua}
            onChange={(e) => setAgua(parseFloat(e.target.value))}
            className="w-full border rounded px-3 py-2 shadow-sm"
          />
        </div>

        {/* Horas de sueño */}
        <div>
          <label className="block text-sm font-medium mb-1">Horas de sueño</label>
          <input
            type="number"
            min={0}
            max={24}
            value={suenoHoras}
            onChange={(e) => setSuenoHoras(Number(e.target.value))}
            className="w-full border rounded px-3 py-2 shadow-sm"
          />
        </div>

        {/* Calidad del sueño */}
        <div>
          <label className="block text-sm font-medium mb-1">
            Calidad del sueño: {calidadSueno}/5
          </label>
          <input
            type="range"
            min={1}
            max={5}
            value={calidadSueno}
            onChange={(e) => setCalidadSueno(Number(e.target.value))}
            className="w-full accent-blue-600"
          />
        </div>

        {/* Pasos diarios */}
        <div>
          <label className="block text-sm font-medium mb-1">Pasos diarios</label>
          <input
            type="number"
            min={0}
            value={pasos}
            onChange={(e) => setPasos(Number(e.target.value))}
            className="w-full border rounded px-3 py-2 shadow-sm"
          />
        </div>

        {/* Estado de ánimo */}
        <div>
          <label className="block text-sm font-medium mb-1">
            Estado de ánimo: {animo}/5
          </label>
          <input
            type="range"
            min={1}
            max={5}
            value={animo}
            onChange={(e) => setAnimo(Number(e.target.value))}
            className="w-full accent-blue-600"
          />
        </div>

        {/* Nivel de estrés */}
        <div>
          <label className="block text-sm font-medium mb-1">
            Nivel de estrés: {estres}/5
          </label>
          <input
            type="range"
            min={1}
            max={5}
            value={estres}
            onChange={(e) => setEstres(Number(e.target.value))}
            className="w-full accent-blue-600"
          />
        </div>

        {/* Motivación */}
        <div>
          <label className="block text-sm font-medium mb-1">
            Motivación: {motivacion}/5
          </label>
          <input
            type="range"
            min={1}
            max={5}
            value={motivacion}
            onChange={(e) => setMotivacion(Number(e.target.value))}
            className="w-full accent-blue-600"
          />
        </div>

        {/* Tiempo al aire libre */}
        <div>
          <label className="block text-sm font-medium mb-1">Tiempo al aire libre (min)</label>
          <input
            type="number"
            min={0}
            value={aireLibre}
            onChange={(e) => setAireLibre(Number(e.target.value))}
            className="w-full border rounded px-3 py-2 shadow-sm"
          />
        </div>

        {/* Tiempo frente a pantallas */}
        <div>
          <label className="block text-sm font-medium mb-1">Pantallas (horas)</label>
          <input
            type="number"
            min={0}
            value={pantallas}
            onChange={(e) => setPantallas(Number(e.target.value))}
            className="w-full border rounded px-3 py-2 shadow-sm"
          />
        </div>

        {/* Reflexión personal */}
        <div className="md:col-span-2">
          <label className="block text-sm font-medium mb-1">Reflexión personal (opcional)</label>
          <textarea
            value={reflexion}
            onChange={(e) => setReflexion(e.target.value)}
            rows={4}
            className="w-full border rounded px-3 py-2 shadow-sm"
          />
        </div>

        {/* Botón */}
        <div className="md:col-span-2 flex justify-center mt-2">
          <button
            type="submit"
            className="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-6 py-2 rounded shadow"
          >
            Guardar hábitos
          </button>
        </div>
      </form>
    </div>
  );
}

export default HabitosPage;
