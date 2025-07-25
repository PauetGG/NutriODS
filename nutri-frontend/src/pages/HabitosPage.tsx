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
    <h2 className="text-3xl font-bold text-center text-emerald-700 mb-6">
      Registro de hábitos diarios
    </h2>

    {mostrarModalRecomendaciones && (
      <div className="fixed inset-0 z-50 flex items-center justify-center bg-opacity-30 backdrop-blur-sm">
        <div className="relative bg-white p-8 rounded-xl shadow-lg max-w-md w-full mx-4 text-center border border-emerald-300">
          <button
            type="button"
            onClick={() => setMostrarModalRecomendaciones(false)}
            className="absolute top-4 right-4 text-gray-400 hover:text-gray-700 text-2xl font-bold focus:outline-none"
            aria-label="Cerrar"
          >
            ×
          </button>
          <h3 className="text-xl font-extrabold text-emerald-700 mb-4">¡Activa tu mejor versión! 💪🌱</h3>
          <div className="grid grid-cols-1 gap-3 text-lg text-gray-700">
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

    <div className="max-w-6xl mx-auto bg-white border border-emerald-300 shadow-md p-6 rounded-2xl grid grid-cols-1 md:grid-cols-3 gap-6">
      <form
        onSubmit={handleGuardar}
        className="md:col-span-2 grid grid-cols-1 md:grid-cols-2 gap-6"
      >
        {/* Input genérico */}
        {[
          { label: "Litros de agua", value: agua, setter: setAgua, type: "number", step: 0.1 },
          { label: "Horas de sueño", value: suenoHoras, setter: setSuenoHoras, type: "number" },
          { label: "Pasos diarios", value: pasos, setter: setPasos, type: "number" },
          { label: "Tiempo al aire libre (min)", value: aireLibre, setter: setAireLibre, type: "number" },
          { label: "Pantallas (horas)", value: pantallas, setter: setPantallas, type: "number" },
        ].map((field, i) => (
          <div key={i}>
            <label className="block text-sm font-medium mb-1">{field.label}</label>
            <input
              type={field.type}
              step={field.step ?? 1}
              min={0}
              value={field.value}
              onChange={(e) => field.setter(Number(e.target.value))}
              className="w-full border border-gray-300 rounded-full px-4 py-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-emerald-400"
            />
          </div>
        ))}

        {/* Ranges */}
        {[
          { label: "Calidad del sueño", value: calidadSueno, setter: setCalidadSueno },
          { label: "Estado de ánimo", value: animo, setter: setAnimo },
          { label: "Nivel de estrés", value: estres, setter: setEstres },
          { label: "Motivación", value: motivacion, setter: setMotivacion },
        ].map((field, i) => (
          <div key={i}>
            <label className="block text-sm font-medium mb-1">
              {field.label}: {field.value}/5
            </label>
            <input
              type="range"
              min={1}
              max={5}
              value={field.value}
              onChange={(e) => field.setter(Number(e.target.value))}
              className="w-full accent-emerald-500"
            />
          </div>
        ))}

        {/* Reflexión */}
        <div className="md:col-span-2">
          <label className="block text-sm font-medium mb-1">Reflexión personal (opcional)</label>
          <textarea
            value={reflexion}
            onChange={(e) => setReflexion(e.target.value)}
            rows={4}
            className="w-full border border-gray-300 rounded-2xl px-4 py-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-emerald-400"
          />
        </div>

        {/* Botón */}
        <div className="md:col-span-2 flex justify-center mt-2">
          <button
            type="submit"
            className="bg-white border border-emerald-500 text-emerald-700 font-semibold px-6 py-2 rounded-full shadow hover:bg-emerald-50 transition"
            disabled={loading}
          >
            {loading ? "Cargando..." : registroId ? "Actualizar hábitos" : "Guardar hábitos"}
          </button>
        </div>
      </form>

      {/* Avatar visual */}
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
