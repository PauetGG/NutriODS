import { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import axios from "axios";
import Swal from "sweetalert2";
import { useAuth } from "../context/useAuth";
import { FaArrowLeft } from "react-icons/fa";
import { useMemo } from "react";

export default function TemaPage() {
  const { id } = useParams();
  const { id: idUsuario } = useAuth();
  const [tema, setTema] = useState<any>(null);
  const [respuestas, setRespuestas] = useState<any[]>([]);
  const [likeado, setLikeado] = useState(false);
  const [likes, setLikes] = useState(0);

  const navigate = useNavigate();

  useEffect(() => {
    if (!id) return;
    // Sumar visita
    axios.post(`http://localhost:8080/api/foro/temas/${id}/incrementar-visitas`).catch(() => {});
    // Cargar tema
    axios.get(`http://localhost:8080/api/foro/temas/${id}`).then(res => setTema(res.data));
    // Cargar respuestas
    axios.get(`http://localhost:8080/api/foro/respuestas/tema/${id}`).then(res => setRespuestas(res.data));
    axios.get(`http://localhost:8080/api/foro/likes-tema/count/${id}`).then(res => setLikes(res.data));
  }, [id]);

  const handleLike = async () => {
    if (!idUsuario) {
      Swal.fire({ icon: "error", title: "Debes iniciar sesión para dar like" });
      return;
    }
    // Aquí pon el endpoint real para dar like si lo tienes
    // await axios.post(`http://localhost:8080/api/foro/temas/${id}/like`, { usuario: { id: idUsuario } });
    setLikeado(true);
    Swal.fire({ icon: "success", title: "¡Te ha gustado este tema!" });
    // Opcional: recargar tema para actualizar likes
  };

  // Divide el contenido en líneas de 18 palabras para mejorar la legibilidad
  const contenidoFormateado = useMemo(() => {
    if (!tema?.contenido) return "";
    const palabras = tema.contenido.split(/\s+/);
    const lineas = [];
    for (let i = 0; i < palabras.length; i += 18) {
      lineas.push(palabras.slice(i, i + 18).join(" "));
    }
    return lineas.join("\n");
  }, [tema]);
  if (!tema) return <div className="text-center p-8">Cargando...</div>;

  return (
    <div className="max-w-6xl mx-auto p-10 bg-gradient-to-br from-emerald-50 via-white to-emerald-100 rounded-3xl shadow-2xl border border-emerald-100">
      <div className="flex flex-col gap-2 mb-6">
        <div className="flex flex-row items-center gap-4 mb-2">
          <button
            onClick={() => navigate(-1)}
            className="flex items-center gap-2 text-red-600 hover:text-red-800 font-semibold px-4 py-2 rounded-full transition-colors border border-red-100 bg-red-50 hover:bg-red-100 shadow-lg"
            style={{ minWidth: 90 }}
          >
            <FaArrowLeft className="text-xl" />
            Atrás
          </button>
          <h2 className="text-3xl font-extrabold text-emerald-700 tracking-tight leading-tight mb-0 ml-4" style={{textShadow: '0 2px 8px #a7f3d0'}}>
            {tema.titulo}
          </h2>
        </div>
        {/* Autor y fecha debajo de la primera letra del título */}
        <div className="flex flex-row items-center gap-2 text-gray-500 text-sm font-semibold mb-4 ml-[calc(90px+1rem)]">
          <span>{tema.usuario?.username || "Anónimo"}</span>
          <span>·</span>
          <span>{new Date(tema.created).toLocaleDateString("es-ES")}</span>
        </div>
      </div>
      <div className="mb-8 text-gray-800 break-words whitespace-pre-line max-w-full text-lg leading-relaxed font-medium" style={{wordBreak: 'break-word', fontFamily: 'inherit'}}>
        {contenidoFormateado}
      </div>
      <div className="flex gap-6 items-center mb-4 pl-2">
        <span className="text-emerald-700 font-semibold">👁️ {tema.visitas} visitas</span>
      </div>
      <hr className="my-4" />
      <h3 className="text-lg font-semibold mb-2">Respuestas</h3>
      <ul className="mb-4">
        {respuestas.map((r) => (
          <li key={r.id} className="mb-2 border-b pb-2">
            <div className="font-bold">{r.usuario?.username || "Anónimo"}</div>
            <div>{r.contenido}</div>
          </li>
        ))}
      </ul>
    </div>
  );
}
