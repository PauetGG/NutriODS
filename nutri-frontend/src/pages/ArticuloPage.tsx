import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { useAuth } from "../context/useAuth";
import type { Articulo } from "../types/Articulo";

type Comentario = {
  id: number;
  usuario?: { id: number; nombre: string };
  articulo: { id: number };
  contenido: string;
  fecha: string;
};

export default function ArticuloPage() {
  const { id } = useParams<{ id: string }>();
  const { id: usuarioId, nombre } = useAuth();

  const [articulo, setArticulo] = useState<Articulo | null>(null);
  const [comentarios, setComentarios] = useState<Comentario[]>([]);
  const [nuevoComentario, setNuevoComentario] = useState("");
  const [likeado, setLikeado] = useState(false);
  const [favorito, setFavorito] = useState(false);
  const [likes, setLikes] = useState(0);

  useEffect(() => {
    if (!id || !usuarioId) return;

    fetch(`http://localhost:8080/api/articulos/${id}`)
      .then((res) => res.json())
      .then(setArticulo);

    fetch(`http://localhost:8080/api/articulos/${id}/visita/${usuarioId}`, {
      method: "PUT",
    });

    fetch(`http://localhost:8080/api/articulos/likes/count/${id}`)
      .then((res) => res.json())
      .then(setLikes);

    fetch(`http://localhost:8080/api/articulos/likes/exists?articuloId=${id}&usuarioId=${usuarioId}`)
      .then((res) => setLikeado(res.ok));

    fetch(`http://localhost:8080/api/articulos/favoritos/exists?articuloId=${id}&usuarioId=${usuarioId}`)
      .then((res) => setFavorito(res.ok));

    fetch(`http://localhost:8080/api/articulos/comentarios/articulo/${id}`)
      .then((res) => res.json())
      .then(setComentarios);
  }, [id, usuarioId]);

  const toggleLike = async () => {
    if (!id || !usuarioId) return;

    if (likeado) {
      await fetch(`http://localhost:8080/api/articulos/likes?articuloId=${id}&usuarioId=${usuarioId}`, {
        method: "DELETE",
      });
      setLikes((prev) => prev - 1);
    } else {
      await fetch(`http://localhost:8080/api/articulos/likes`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          articulo: { id: Number(id) },
          usuario: { id: usuarioId },
        }),
      });
      setLikes((prev) => prev + 1);
    }
    setLikeado(!likeado);
  };

  const toggleFavorito = async () => {
    if (!id || !usuarioId) return;

    if (favorito) {
      await fetch(`http://localhost:8080/api/artis/favoritos/${usuarioId}/${id}`, {
        method: "DELETE",
      });
    } else {
      await fetch(`http://localhost:8080/api/artis/favoritos`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          articulo: { id: Number(id) },
          usuario: { id: usuarioId },
        }),
      });
    }
    setFavorito(!favorito);
  };

  const enviarComentario = async () => {
    if (!nuevoComentario.trim() || !usuarioId || !nombre) return;

    const res = await fetch(`http://localhost:8080/api/articulos/comentarios`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        articulo: { id: Number(id) },
        usuario: { id: usuarioId, nombre },
        contenido: nuevoComentario,
      }),
    });

    if (res.ok) {
      const nuevo = await res.json();
      setComentarios((prev) => [...prev, nuevo]);
      setNuevoComentario("");
    }
  };

  if (!articulo)
    return <div className="p-6 text-center text-gray-600 text-lg">Cargando artículo...</div>;

  return (
    <div className="p-6 max-w-4xl mx-auto bg-white rounded-2xl shadow-xl mt-12 transition-all">
      <img
        src={articulo.imagenUrl}
        alt={articulo.titulo}
        className="w-full h-72 object-contain rounded-xl mb-6 shadow-sm"
      />

      <h1 className="text-4xl font-extrabold mb-2 text-emerald-700">{articulo.titulo}</h1>
      <p className="text-sm text-gray-500 mb-3">
        {new Date(articulo.fechaPublicacion).toLocaleDateString()} ·{" "}
        <span className="font-medium text-gray-600">{articulo.autor}</span>
      </p>

      <span className="inline-block bg-emerald-100 text-emerald-700 text-xs font-semibold px-3 py-1 rounded-full mb-6 uppercase tracking-wide">
        {articulo.categoria}
      </span>

      <p className="text-base leading-7 text-gray-800 whitespace-pre-wrap">
        {articulo.contenido}
      </p>

      <div className="mt-8 flex flex-wrap gap-4 items-center">
        <button
          onClick={toggleLike}
          className="flex items-center gap-2 text-rose-600 font-medium hover:underline transition"
        >
          {likeado ? "❤️ Me gusta" : "🤍 Me gusta"} ({likes})
        </button>
        <button
          onClick={toggleFavorito}
          className="flex items-center gap-2 text-yellow-500 font-medium hover:underline transition"
        >
          {favorito ? "⭐ Favorito" : "☆ Marcar favorito"}
        </button>
      </div>

      <div className="mt-10">
        <h3 className="text-2xl font-semibold text-gray-800 mb-4">Comentarios</h3>

        {comentarios.length === 0 ? (
          <p className="text-sm text-gray-500 italic">Aún no hay comentarios. Sé el primero en participar.</p>
        ) : (
          comentarios.map((com) => (
            <div key={com.id} className="mb-5 bg-gray-50 rounded-md p-3 border border-gray-200">
              <div className="flex justify-between items-center mb-1">
                <p className="text-sm font-medium text-gray-700">{com.usuario?.nombre ?? "Usuario eliminado"}</p>
                <p className="text-xs text-gray-400">{new Date(com.fecha).toLocaleString()}</p>
              </div>
              <p className="text-sm text-gray-800">{com.contenido}</p>
            </div>
          ))
        )}

        <textarea
          className="w-full border border-gray-300 rounded-lg p-3 mt-6 focus:ring-2 focus:ring-emerald-500 focus:outline-none resize-none"
          rows={4}
          placeholder="Escribe tu comentario..."
          value={nuevoComentario}
          onChange={(e) => setNuevoComentario(e.target.value)}
        />
        <button
          onClick={enviarComentario}
          className="mt-3 px-6 py-2 bg-emerald-600 hover:bg-emerald-700 text-white font-semibold rounded-lg transition-all"
        >
          Comentar
        </button>
      </div>
    </div>
  );
}
