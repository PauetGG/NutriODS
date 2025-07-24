import { useEffect, useState } from "react";
import { AvatarViewer } from "../components/AvatarViewer";
import { useAuth } from "../context/useAuth";
import axios from "axios";
import { useParams } from "react-router-dom";
import { ChevronDownIcon, ChevronUpIcon } from "lucide-react";
import Swal from "sweetalert2";

const modelosChico = [
  "https://models.readyplayer.me/686e3c51102ef4f7b8044753.glb",
  "https://models.readyplayer.me/686e47a189f902e00fa3dc5c.glb",
  "https://models.readyplayer.me/686e4810e9d87263ed896053.glb",
  "https://models.readyplayer.me/686e485c102ef4f7b8054b59.glb",
];

const modelosChica = [
  "https://models.readyplayer.me/686e4a2b1b0fb8ecbf1a4889.glb",
  "https://models.readyplayer.me/686e471a53055188366e772f.glb",
  "https://models.readyplayer.me/686e4ac8102ef4f7b80583e1.glb",
  "https://models.readyplayer.me/686e4b1453055188366ed1ca.glb",
];

export const ProgresoPage = () => {
  const { id } = useAuth();
  const { dietaId } = useParams<{ dietaId: string }>();
  const [avatarActual, setAvatarActual] = useState("");
  const [avatarDeseado, setAvatarDeseado] = useState("");
  const [imc, setImc] = useState<number | null>(null);
  const [genero, setGenero] = useState("");
  const [altura, setAltura] = useState<number>(1.7);
  const [pesoActual, setPesoActual] = useState<number | null>(null);
  const [pesoDeseado, setPesoDeseado] = useState<number | null>(null);
  const [imcDeseado, setImcDeseado] = useState<number | null>(null);

  // Formulario
  const [pesoRegistro, setPesoRegistro] = useState<number | null>(null);
  const [velocidad, setVelocidad] = useState<number | null>(null);
  const [tiempo, setTiempo] = useState<number | null>(null);
  const [zonaMuscular, setZonaMuscular] = useState<"superior" | "inferior" | "">("");
  const [ejercicioGym, setEjercicioGym] = useState("");
  const [repsEjercicio, setRepsEjercicio] = useState<number | null>(null);
  const [pesoEjercicio, setPesoEjercicio] = useState<number | null>(null);
  const [ejerciciosGimnasio, setEjerciciosGimnasio] = useState<
  { ejercicio: string; zona: string; peso: number; reps: number }[]
>([]);
  const [tipoFuerza, setTipoFuerza] = useState<"calistenia" | "gimnasio" | "">("");
  const [entrenoHoy, setEntrenoHoy] = useState<"si" | "no" | "">("");
  const [ejerciciosCalistenia, setEjerciciosCalistenia] = useState<
    { ejercicio: string; repeticiones: number }[]
  >([]);
  const [ejercicioSeleccionado, setEjercicioSeleccionado] = useState("");
  const [repsSeleccionadas, setRepsSeleccionadas] = useState<number | null>(null);
  const [tipoEntreno, setTipoEntreno] = useState<string>("");
  const [mostrarAvatarDeseado, setMostrarAvatarDeseado] = useState(false);
  const [idSeguimientoExistente, setIdSeguimientoExistente] = useState<number | null>(null);


  const obtenerModelo = (imc: number, genero: string) => {
    const index = imc < 18.5 ? 0 : imc < 25 ? 1 : imc < 30 ? 2 : 3;
    return genero === "masculino" ? modelosChico[index] : modelosChica[index];
  };

  useEffect(() => {
    const fetchDatos = async () => {
      try {
        // 1. Obtener datos del usuario
        const userRes = await axios.get(`http://localhost:8080/api/usuarios/${id}`);
        const generoUsuario = userRes.data.genero?.toLowerCase() || "masculino";
        const alturaUsuario = parseFloat(userRes.data.altura);
        const pesoUsuario = parseFloat(userRes.data.peso);

        setGenero(generoUsuario);
        setAltura(alturaUsuario);
        setPesoActual(pesoUsuario);
        setPesoRegistro(pesoUsuario);

        // 2. Calcular IMC y asignar avatar actual y deseado
        const imcRes = await axios.get(`http://localhost:8080/api/usuarios/${id}/imc`);
        const imcActual = imcRes.data.imc;
        setImc(imcActual);

        const modeloActual = obtenerModelo(imcActual, generoUsuario);
        setAvatarActual(modeloActual);
        setAvatarDeseado(modeloActual);
        setPesoDeseado(pesoUsuario);

        // 3. Verificar si ya existe seguimiento físico para hoy
        const hoy = new Date().toISOString().split("T")[0];
        const seguimientoRes = await axios.get(`http://localhost:8080/api/seguimiento-fisico/buscar`, {
          params: { dietaId: dietaId, fecha: hoy },
        });

        const data = seguimientoRes.data;
        setIdSeguimientoExistente(data.id);

        // Precargar datos en el formulario si ya existe
        setPesoRegistro(data.peso);
        setEntrenoHoy(data.entrenoHoy ? "si" : "no");
        setTipoEntreno(data.tipoEntreno || "");
        setTipoFuerza(data.tipoFuerza || "");
        setVelocidad(data.velocidad || null);
        setTiempo(data.tiempo || null);
        setEjerciciosGimnasio(data.gimnasioEjercicios || []);
        setEjerciciosCalistenia(data.calisteniaEjercicios || []);
      } catch (error) {
        console.log("No hay seguimiento físico registrado hoy o error al cargar:", error);
      }
    };

    if (id) fetchDatos();
  }, [id]);

  const handlePesoDeseadoChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const nuevoPeso = parseFloat(e.target.value);
    setPesoDeseado(nuevoPeso);

    if (nuevoPeso && altura) {
      const nuevoIMC = nuevoPeso / (altura * altura);
      setImcDeseado(nuevoIMC);
      setAvatarDeseado(obtenerModelo(nuevoIMC, genero));
    }
  };

  const handleGuardarProgreso = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      const url = idSeguimientoExistente
      ? `http://localhost:8080/api/seguimiento-fisico/${idSeguimientoExistente}`
      : `http://localhost:8080/api/seguimiento-fisico`;

    const method = idSeguimientoExistente ? "put" : "post";

    await axios({
      method,
      url,
      headers: {
        "Content-Type": "application/json",
      },
      data: {
        dieta: { id: dietaId }, // 👈 Aquí está el cambio clave
        fecha: new Date().toISOString().split("T")[0],
        diaSemana: new Date().toLocaleDateString("es-ES", { weekday: "long" }).toLowerCase(),
        semana: obtenerNumeroSemana(new Date()),
        peso: pesoRegistro,
        entrenoHoy: entrenoHoy === "si",
        tipoEntreno: tipoEntreno || null,
        tipoFuerza: tipoFuerza || null,
        velocidad: tipoEntreno !== "fuerza" ? velocidad : null,
        tiempo: tipoEntreno !== "fuerza" ? tiempo : null,
        gimnasioEjercicios:
          tipoFuerza === "gimnasio"
            ? ejerciciosGimnasio.map((e) => ({
                ejercicio: e.ejercicio,
                zona: e.zona,
                reps: e.reps,
                peso: e.peso,
              }))
            : [],
        calisteniaEjercicios:
          tipoFuerza === "calistenia"
            ? ejerciciosCalistenia.map((e) => ({
                ejercicio: e.ejercicio,
                repeticiones: e.repeticiones,
              }))
            : [],
      },
    });
      await Swal.fire({
        icon: "success",
        title: "¡Progreso guardado!",
        text: "Tu progreso se ha guardado correctamente.",
        confirmButtonColor: "#2563eb", // azul
      });
    } catch (error) {
      console.error("Error al guardar el progreso:", error);
      await Swal.fire({
        icon: "error",
        title: "Error",
        text: "Hubo un error al guardar el progreso.",
        confirmButtonColor: "#ef4444", // rojo
      });
    }
  };
   
  const obtenerNumeroSemana = (fecha: Date) => {
  const inicio = new Date(fecha.getFullYear(), 0, 1);
  const diff = (fecha.getTime() - inicio.getTime()) / (1000 * 60 * 60 * 24);
  return Math.ceil((diff + inicio.getDay() + 1) / 7);
};


  const renderFuerza = () => (
  <div className="mt-4">
    <label className="text-sm font-medium mb-1 block">Tipo de fuerza</label>
    <select
      value={tipoFuerza}
      onChange={(e) => {
        setTipoFuerza(e.target.value as "calistenia" | "gimnasio");
        setZonaMuscular("");
      }}
      className="w-full border rounded px-4 py-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
    >
      <option value="">Selecciona</option>
      <option value="calistenia">Calistenia</option>
      <option value="gimnasio">Gimnasio</option>
    </select>

    {/* BLOQUE CALISTENIA */}
    {tipoFuerza === "calistenia" && (
      <div className="mt-4">
        <label className="text-sm font-medium mb-1 block">Ejercicios de calistenia</label>
        <div className="flex flex-col md:flex-row gap-4">
          <select
            value={ejercicioSeleccionado}
            onChange={(e) => setEjercicioSeleccionado(e.target.value)}
            className="border rounded px-4 py-2 shadow-sm w-full md:w-1/2"
          >
            <option value="">Selecciona ejercicio</option>
            <option value="flexiones">Flexiones</option>
            <option value="dominadas">Dominadas</option>
            <option value="fondos">Fondos en paralelas</option>
            <option value="sentadillas">Sentadillas</option>
            <option value="muscle-up">Muscle-up</option>
            <option value="l-sit">L-sit</option>
            <option value="pistols">Pistols (una pierna)</option>
          </select>

          <input
            type="number"
            placeholder="Repeticiones máximas"
            min={1}
            value={repsSeleccionadas ?? ""}
            onChange={(e) => setRepsSeleccionadas(parseInt(e.target.value))}
            className="border rounded px-4 py-2 shadow-sm w-full md:w-1/2"
          />
        </div>

        <button
          type="button"
          onClick={() => {
            if (ejercicioSeleccionado && repsSeleccionadas) {
              setEjerciciosCalistenia((prev) => [
                ...prev,
                { ejercicio: ejercicioSeleccionado, repeticiones: repsSeleccionadas },
              ]);
              setEjercicioSeleccionado("");
              setRepsSeleccionadas(null);
            }
          }}
          className="mt-2 bg-blue-500 text-white px-4 py-1 rounded hover:bg-blue-600"
        >
          Añadir ejercicio
        </button>

        {ejerciciosCalistenia.length > 0 && (
          <ul className="mt-3 space-y-1 text-sm text-gray-700">
            {ejerciciosCalistenia.map((item, index) => (
              <li key={index} className="flex justify-between items-center bg-gray-100 px-3 py-1 rounded">
                <span>{item.ejercicio} – {item.repeticiones} reps</span>
                <button
                  type="button"
                  onClick={() => setEjerciciosCalistenia(prev => prev.filter((_, i) => i !== index))}
                  className="text-red-500 text-xs hover:underline"
                >
                  Eliminar
                </button>
              </li>
            ))}
          </ul>
        )}
      </div>
    )}

    {/* BLOQUE GIMNASIO */}
    {tipoFuerza === "gimnasio" && (
      <div className="mt-4">
        <label className="text-sm font-medium mb-1 block">Zona muscular</label>
        <select
          value={zonaMuscular}
          onChange={(e) => {
            setZonaMuscular(e.target.value as "superior" | "inferior");
            setEjercicioGym("");
          }}
          className="border rounded px-4 py-2 shadow-sm mb-4 w-full"
        >
          <option value="">Selecciona zona</option>
          <option value="superior">Parte superior</option>
          <option value="inferior">Parte inferior</option>
        </select>

        {zonaMuscular && (
          <>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <select
                value={ejercicioGym}
                onChange={(e) => setEjercicioGym(e.target.value)}
                className="border rounded px-4 py-2 shadow-sm"
              >
                <option value="">Selecciona ejercicio</option>
                {zonaMuscular === "superior" && (
                  <>
                    <option value="press banca">Press banca</option>
                    <option value="remo">Remo</option>
                    <option value="triceps">Tríceps</option>
                    <option value="biceps">Bíceps</option>
                    <option value="press militar">Press militar</option>
                    <option value="elevaciones laterales">Elevaciones laterales</option>
                    <option value="face pull">Face pull</option>
                    <option value="jalon pecho">Jalón al pecho</option>
                  </>
                )}
                {zonaMuscular === "inferior" && (
                  <>
                    <option value="sentadilla">Sentadilla</option>
                    <option value="peso muerto">Peso muerto</option>
                    <option value="prensa">Prensa</option>
                    <option value="gemelos">Gemelos</option>
                    <option value="extension cuadriceps">Extensión de cuádriceps</option>
                    <option value="curl femoral">Curl femoral</option>
                    <option value="adductores">Adductores</option>
                    <option value="hip trust">Hip Trust</option>
                  </>
                )}
              </select>

              <input
                type="number"
                min={0}
                placeholder="Kg movidos"
                value={pesoEjercicio ?? ""}
                onChange={(e) => setPesoEjercicio(parseFloat(e.target.value))}
                className="border rounded px-4 py-2 shadow-sm"
              />

              <input
                type="number"
                min={1}
                placeholder="Reps"
                value={repsEjercicio ?? ""}
                onChange={(e) => setRepsEjercicio(parseInt(e.target.value))}
                className="border rounded px-4 py-2 shadow-sm"
              />
            </div>

            <button
              type="button"
              onClick={() => {
                if (
                  ejercicioGym &&
                  zonaMuscular &&
                  pesoEjercicio !== null &&
                  repsEjercicio !== null
                ) {
                  setEjerciciosGimnasio((prev) => [
                    ...prev,
                    {
                      ejercicio: ejercicioGym,
                      zona: zonaMuscular,
                      peso: pesoEjercicio,
                      reps: repsEjercicio,
                    },
                  ]);
                  setEjercicioGym("");
                  setPesoEjercicio(null);
                  setRepsEjercicio(null);
                }
              }}
              className="mt-2 bg-blue-500 text-white px-4 py-1 rounded hover:bg-blue-600"
            >
              Añadir ejercicio
            </button>

            {ejerciciosGimnasio.length > 0 && (
              <ul className="mt-3 space-y-1 text-sm text-gray-700">
                {ejerciciosGimnasio.map((item, index) => (
                  <li
                    key={index}
                    className="flex justify-between items-center bg-gray-100 px-3 py-1 rounded"
                  >
                    <span>
                      {item.zona} – {item.ejercicio}: {item.peso} kg, {item.reps} reps
                    </span>
                    <button
                      type="button"
                      onClick={() =>
                        setEjerciciosGimnasio((prev) => prev.filter((_, i) => i !== index))
                      }
                      className="text-red-500 text-xs hover:underline"
                    >
                      Eliminar
                    </button>
                  </li>
                ))}
              </ul>
            )}
          </>
        )}
      </div>
    )}
  </div>
);


  return (
    <div className="p-6 space-y-10 bg-gray-100 min-h-screen">
      <h2 className="text-2xl font-bold text-center text-blue-800">Tu progreso</h2>

      {/* AVATAR + FORMULARIO */}
      <div className="flex flex-col md:flex-row gap-8 justify-around items-start">
        <div className="bg-white shadow-lg px-4 pt-4 pb-1 rounded-xl border w-full md:w-1/2 text-center">
          <h3 className="text-lg font-semibold text-blue-700 mb-2">Estado actual</h3>
          {pesoActual && <p className="text-sm text-gray-600">Peso actual: {pesoActual} kg</p>}
          {imc && <p className="text-sm text-gray-600 mb-1">IMC actual: {imc.toFixed(1)}</p>}
          {avatarActual && <AvatarViewer url={avatarActual} height={350} />}
        </div>

        <div className="w-full md:w-1/2 bg-white shadow-xl border border-blue-300 p-6 rounded-xl">
          <h3 className="text-lg font-semibold text-blue-700 mb-4">Registrar progreso físico</h3>
          <form onSubmit={handleGuardarProgreso} className="grid grid-cols-1 gap-4">
            <div>
              <label className="text-sm font-medium mb-1 block">Peso (kg)</label>
              <input
                type="number"
                min={30}
                max={200}
                step="0.1"
                value={pesoRegistro ?? ""}
                onChange={(e) => setPesoRegistro(parseFloat(e.target.value))}
                className="w-full border rounded px-4 py-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                required
              />
            </div>

            <div className="flex gap-4">
              <label className="inline-flex items-center">
                <input
                  type="radio"
                  name="entreno"
                  value="si"
                  checked={entrenoHoy === "si"}
                  onChange={() => setEntrenoHoy("si")}
                  className="mr-2 accent-blue-600"
                />
                Entrené hoy
              </label>
              <label className="inline-flex items-center">
                <input
                  type="radio"
                  name="entreno"
                  value="no"
                  checked={entrenoHoy === "no"}
                  onChange={() => setEntrenoHoy("no")}
                  className="mr-2 accent-blue-600"
                />
                No entrené
              </label>
            </div>

            {entrenoHoy === "si" && (
              <>
                <select
                  value={tipoEntreno}
                  onChange={(e) => setTipoEntreno(e.target.value)}
                  className="border rounded px-4 py-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                >
                  <option value="">Tipo de entrenamiento</option>
                  <option value="fuerza">Fuerza</option>
                  <option value="resistencia">Resistencia</option>
                  <option value="ambas">Ambas</option>
                </select>

               {(tipoEntreno === "resistencia" || tipoEntreno === "ambas") && (
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                      <label className="text-sm font-medium mb-1 block">Velocidad (km/h)</label>
                      <input
                        type="number"
                        min={0}
                        value={velocidad ?? ""}
                        onChange={(e) => setVelocidad(parseFloat(e.target.value))}
                        className="w-full border rounded px-4 py-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                      />
                    </div>
                    <div>
                      <label className="text-sm font-medium mb-1 block">Tiempo (min)</label>
                      <input
                        type="number"
                        min={0}
                        value={tiempo ?? ""}
                        onChange={(e) => setTiempo(parseFloat(e.target.value))}
                        className="w-full border rounded px-4 py-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                      />
                    </div>
                  </div>
                )}

                {(tipoEntreno === "fuerza" || tipoEntreno === "ambas") && renderFuerza()}
              </>
            )}
            <button
              type="submit"
              className="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-6 py-2 rounded shadow"
            >
              {idSeguimientoExistente ? "Actualizar progreso" : "Guardar progreso"}
            </button>
          </form>
        </div>
        </div>
      {/* PESTAÑA AVATAR DESEADO */}
      <div className="text-center mt-10">
        <button
          onClick={() => setMostrarAvatarDeseado((prev) => !prev)}
          className="flex items-center justify-center gap-2 mx-auto bg-blue-100 hover:bg-blue-200 text-blue-800 font-semibold px-4 py-2 rounded-full shadow transition"
        >
          {mostrarAvatarDeseado ? (
            <>
              Ocultar vista de peso deseado <ChevronUpIcon size={18} />
            </>
          ) : (
            <>
              ¿Cómo te verás con tu peso deseado? <ChevronDownIcon size={18} />
            </>
          )}
        </button>

        {mostrarAvatarDeseado && (
          <div className="mt-6 bg-white rounded-xl shadow-md border p-6 w-full max-w-lg mx-auto transition-all duration-300">
            <h3 className="text-lg font-semibold text-blue-700 mb-2">Peso deseado</h3>
            <input
              type="number"
              min={30}
              max={150}
              value={pesoDeseado ?? ""}
              onChange={handlePesoDeseadoChange}
              className="border px-4 py-2 rounded text-center mb-2 shadow focus:ring-2 focus:ring-blue-500 w-full"
            />
            {imcDeseado && (
              <p className="text-sm text-gray-600 mb-2">IMC estimado: {imcDeseado.toFixed(1)}</p>
            )}
            {avatarDeseado && <AvatarViewer url={avatarDeseado} height={420} />}
          </div>
        )}
      </div>
    </div>
  );

};

export default ProgresoPage;
