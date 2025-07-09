import { useEffect, useState } from "react";
import { AvatarViewer } from "../components/AvatarViewer";
import { useAuth } from "../context/useAuth";
import axios from "axios";

const modelosChico = [
  "https://models.readyplayer.me/686e3c51102ef4f7b8044753.glb", // delgado
  "https://models.readyplayer.me/686e47a189f902e00fa3dc5c.glb", // normal
  "https://models.readyplayer.me/686e4810e9d87263ed896053.glb", // sobrepeso
  "https://models.readyplayer.me/686e485c102ef4f7b8054b59.glb", // obeso
];

const modelosChica = [
  "https://models.readyplayer.me/686e4a2b1b0fb8ecbf1a4889.glb", // delgada
  "https://models.readyplayer.me/686e471a53055188366e772f.glb", // normal
  "https://models.readyplayer.me/686e4ac8102ef4f7b80583e1.glb", // sobrepeso
  "https://models.readyplayer.me/686e4b1453055188366ed1ca.glb", // obesa
];

export const ProgresoPage = () => {
  const { id } = useAuth();
  const [avatarActual, setAvatarActual] = useState("");
  const [avatarDeseado, setAvatarDeseado] = useState("");
  const [imc, setImc] = useState<number | null>(null);
  const [genero, setGenero] = useState("");
  const [altura, setAltura] = useState<number>(1.7);
  const [pesoActual, setPesoActual] = useState<number | null>(null);
  const [pesoDeseado, setPesoDeseado] = useState<number | null>(null);
  const [imcDeseado, setImcDeseado] = useState<number | null>(null);

  const obtenerModelo = (imc: number, genero: string) => {
    const index = imc < 18.5 ? 0 : imc < 25 ? 1 : imc < 30 ? 2 : 3;
    return genero === "masculino" ? modelosChico[index] : modelosChica[index];
  };

  useEffect(() => {
    const fetchDatos = async () => {
      try {
        const userRes = await axios.get(`http://localhost:8080/api/usuarios/${id}`);
        const generoUsuario = userRes.data.genero?.toLowerCase() || "masculino";
        const alturaUsuario = parseFloat(userRes.data.altura);
        const pesoUsuario = parseFloat(userRes.data.peso);

        setGenero(generoUsuario);
        setAltura(alturaUsuario);
        setPesoActual(pesoUsuario);

        const imcRes = await axios.get(`http://localhost:8080/api/usuarios/${id}/imc`);
        const imcActual = imcRes.data.imc;
        setImc(imcActual);

        const modeloActual = obtenerModelo(imcActual, generoUsuario);
        setAvatarActual(modeloActual);
        setAvatarDeseado(modeloActual);
        setPesoDeseado(pesoUsuario);
      } catch (error) {
        console.error("Error al cargar datos:", error);
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

  return (
    <div className="p-6 space-y-6">
      <h2 className="text-xl font-bold">Tu progreso</h2>

      <div className="flex flex-col md:flex-row gap-8 justify-around">
        {/* AVATAR ACTUAL */}
        <div className="text-center w-full md:w-1/2">
          <h3 className="mb-2 font-semibold">Estado actual</h3>
          {pesoActual && (
            <p className="text-sm text-gray-600">Peso actual: {pesoActual} kg</p>
          )}
          {imc && (
            <p className="text-sm text-gray-600 mb-1">IMC actual: {imc.toFixed(1)}</p>
          )}
          {avatarActual && <AvatarViewer url={avatarActual} />}
        </div>

        {/* AVATAR DESEADO */}
        <div className="text-center w-full md:w-1/2">
          <h3 className="mb-2 font-semibold">Peso deseado</h3>
          <input
            type="number"
            min={30}
            max={150}
            value={pesoDeseado ?? ""}
            onChange={handlePesoDeseadoChange}
            className="border px-3 py-1 rounded text-center mb-2"
          />
          {imcDeseado && (
            <p className="text-sm text-gray-600 mb-1">
              IMC estimado: {imcDeseado.toFixed(1)}
            </p>
          )}
          {avatarDeseado && <AvatarViewer url={avatarDeseado} />}
        </div>
      </div>
    </div>
  );
};

export default ProgresoPage;
