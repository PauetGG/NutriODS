import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import axios from "axios";
import Swal from "sweetalert2";
import { useAuth } from "../context/useAuth";

export default function TemaPage() {
  const { id } = useParams();
  const { id: idUsuario } = useAuth();
  const [tema, setTema] = useState<any>(null);
  const [respuestas, setRespuestas] = useState<any[]>([]);
  const [nuevaRespuesta, setNuevaRespuesta] = useState("");
  const [likeado, setLikeado] = useState(false);

  useEffect(() => {
    if (!id) return;
    // Sumar visita
    axios.post(`http://localhost:8080/api/foro/temas/${id}/incrementar-visitas`).catch(() => {});
    // Cargar tema
    axios.get(`http://localhost:8080/api/foro/temas/${id}`).then(res => setTema(res.data));
    // Cargar respuestas
    axios.get(`http://localhost:8080/api/foro/respuestas/tema/${id}`).then(res => setRespuestas(res.data));
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

  const handleResponder = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!nuevaRespuesta.trim()) return;
    if (!idUsuario) {
      Swal.fire({ icon: "error", title: "Debes iniciar sesión para responder" });
      return;
    }
    await axios.post("http://localhost:8080/api/foro/respuestas", {
      usuario: { id: idUsuario },
      tema: { id: id },
      contenido: nuevaRespuesta,
    });
    setNuevaRespuesta("");
    // Recargar respuestas
    axios.get(`http://localhost:8080/api/foro/respuestas/tema/${id}`).then(res => setRespuestas(res.data));
  };

  if (!tema) return <div className="text-center p-8">Cargando...</div>;

  return (
    <div className="max-w-2xl mx-auto p-6">
      <h2 className="text-2xl font-bold mb-2">{tema.titulo}</h2>
      <div className="mb-2 text-gray-600">{tema.contenido}</div>
      <div className="flex gap-4 items-center mb-4">
        <span>👁️ {tema.visitas} visitas</span>
        <button
          onClick={handleLike}
          className={`text-pink-600 font-bold ${likeado ? 'opacity-50 pointer-events-none' : ''}`}
          disabled={likeado}
        >
          ❤️ Like
        </button>
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
      <form onSubmit={handleResponder} className="flex flex-col gap-2">
        <textarea
          value={nuevaRespuesta}
          onChange={e => setNuevaRespuesta(e.target.value)}
          placeholder="Escribe tu respuesta..."
          className="border rounded p-2"
        />
        <button type="submit" className="bg-emerald-600 text-white rounded px-4 py-2">Responder</button>
      </form>
    </div>
  );
}
