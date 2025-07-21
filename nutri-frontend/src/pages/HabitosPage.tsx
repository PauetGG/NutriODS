import { useEffect, useState } from "react";
import { AvatarHabitos } from "../components/AvatarHabitos";
import Swal from "sweetalert2";

function HabitosPage() {
  // Ajusta esto según tu lógica de usuario/dieta actual
  const dietaId = 1;
  const today = new Date().toISOString().split("T")[0];

  const [registroId, setRegistroId] = useState<number | null>(null);
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
  const [loading, setLoading] = useState<boolean>(true);
  const [mostrarModalRecomendaciones, setMostrarModalRecomendaciones] = useState(false);

  useEffect(() => {
    setLoading(true);
    fetch(`http://localhost:8080/api/seguimiento-habitos/dieta/${dietaId}/fecha/${today}`)
      .then(res => {
        if (res.ok) return res.json();
        throw new Error("No hay registro para hoy");
      })
      .then(data => {
        setAgua(data.agua);
        setSuenoHoras(data.suenoHoras);
        setCalidadSueno(data.calidadSueno);
        setPasos(data.pasos);
        setAnimo(data.animo);
        setEstres(data.estres);
        setMotivacion(data.motivacion);
        setAireLibre(data.aireLibre);
        setPantallas(data.pantallas);
        setReflexion(data.reflexion || "");
        setRegistroId(data.id);
        setLoading(false);
      })
      .catch(() => {
        setRegistroId(null);
        setAgua(0);
        setSuenoHoras(8);
        setCalidadSueno(3);
        setPasos(0);
        setAnimo(3);
        setEstres(3);
        setMotivacion(3);
        setAireLibre(0);
        setPantallas(0);
        setReflexion("");
        setLoading(false);
      });
  }, [dietaId, today]);

  const handleGuardar = (e: React.FormEvent) => {
    e.preventDefault();
    const datos = {
      id: registroId || undefined,
      dieta: { id: dietaId },
      fecha: today,
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
    fetch("http://localhost:8080/api/seguimiento-habitos", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(datos),
    })
      .then(res => res.json())
      .then(data => {
        Swal.fire({
          icon: "success",
          title: registroId ? "¡Registro actualizado!" : "¡Registro guardado!",
          text: "Tus hábitos se han guardado correctamente.",
          confirmButtonColor: "#2563eb",
        });
        setRegistroId(data.id);
      })
      .catch(() => {
        Swal.fire({
          icon: "error",
          title: "Error",
          text: "Error al guardar el registro.",
          confirmButtonColor: "#ef4444",
        });
      });
  };

  return (
    <div className="p-6 bg-gray-100 min-h-screen">
      <h2 className="text-2xl font-bold text-center text-blue-800 mb-6">
        Registro de hábitos diarios
      </h2>
      {mostrarModalRecomendaciones && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-opacity-30 backdrop-blur-sm">
          <div className="relative bg-white p-8 rounded-xl shadow-lg max-w-md w-full mx-4 text-center">
            <button
              type="button"
              onClick={() => setMostrarModalRecomendaciones(false)}
              className="absolute top-4 right-4 text-gray-400 hover:text-gray-700 text-2xl font-bold focus:outline-none"
              aria-label="Cerrar"
            >
              ×
            </button>
            <h3 className="text-xl font-extrabold text-emerald-700 mb-4">¡Activa tu mejor versión! 💪🌱</h3>
            <div className="grid grid-cols-1 gap-3 text-lg">
              <div>💧 <span className="font-semibold text-emerald-700">Hidrátate:</span> 2L de agua al día</div>
              <div>🚶‍♂️ <span className="font-semibold text-emerald-700">Muévete:</span> 7.000-10.000 pasos diarios</div>
              <div>😴 <span className="font-semibold text-emerald-700">Duerme bien:</span> 7-8h cada noche</div>
              <div>🌳 <span className="font-semibold text-emerald-700">Aire libre:</span> 30+ min al sol y naturaleza</div>
              <div>📵 <span className="font-semibold text-emerald-700">Pantallas:</span> Menos de 3h/día</div>
              <div>😊 <span className="font-semibold text-emerald-700">Ánimo:</span> ¡Rodéate de cosas que te motiven!</div>
              <div>🧘‍♀️ <span className="font-semibold text-emerald-700">Estrés:</span> Respira, relájate y disfruta</div>
            </div>
            <div className="mt-6 text-emerald-600 font-bold text-lg">
              ¡Pequeños hábitos, grandes resultados! 🚀
            </div>
          </div>
        </div>
      )}

      <div className="max-w-6xl mx-auto bg-white border border-blue-300 shadow-xl p-6 rounded-xl grid grid-cols-1 md:grid-cols-3 gap-6">
        {/* Formulario - ocupa 2 columnas */}
        <form
          onSubmit={handleGuardar}
          className="md:col-span-2 grid grid-cols-1 md:grid-cols-2 gap-6"
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
              disabled={loading}
            >
              {loading ? "Cargando..." : registroId ? "Actualizar hábitos" : "Guardar hábitos"}
            </button>
          </div>
        </form>

        {/* Avatar visual - 1 columna */}
        <div className="flex flex-col items-center">
          <button
            type="button"
            onClick={() => setMostrarModalRecomendaciones(true)}
            className="mb-4 bg-emerald-100 hover:bg-emerald-200 text-emerald-800 font-semibold px-4 py-2 rounded-full shadow transition"
          >
            Mostrar recomendaciones
          </button>
          <AvatarHabitos
            pasos={pasos}
            agua={agua}
            suenoHoras={suenoHoras}
            calidadSueno={calidadSueno}
            animo={animo}
            estres={estres}
            motivacion={motivacion}
            aireLibre={aireLibre}
            pantallas={pantallas}
          />
        </div>
      </div>
    </div>
  );
}

export default HabitosPage;
