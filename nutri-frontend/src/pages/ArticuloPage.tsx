import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { useAuth } from "../context/useAuth";
import type { Articulo } from "../types/Articulo";

type Comentario = {
  id: number;
  usuario?: { id: number; nombre: string }; // Puede venir undefined
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

    // ✅ Corrige el endpoint si es necesario
    fetch(`http://localhost:8080/api/articulos/${id}/visita/${usuarioId}`, { method: "PUT" });

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

  if (!articulo) return <div className="p-6 text-center">Cargando artículo...</div>;

  return (
    <div className="p-6 max-w-3xl mx-auto bg-white rounded-xl shadow mt-10">
      <img
        src={articulo.imagenUrl}
        alt={articulo.titulo}
        className="w-full h-64 object-cover rounded mb-6"
      />
      <h1 className="text-3xl font-bold mb-4 text-green-700">{articulo.titulo}</h1>
      <p className="text-sm text-gray-500 mb-2">
        {new Date(articulo.fechaPublicacion).toLocaleDateString()} · {articulo.autor}
      </p>
      <span className="inline-block bg-green-100 text-green-700 text-xs px-2 py-1 rounded mb-4">
        {articulo.categoria}
      </span>

      <p className="text-lg text-gray-800 leading-relaxed mt-4 whitespace-pre-wrap">
        {articulo.contenido}
      </p>

      {/* Likes y favoritos */}
      <div className="mt-6 flex gap-4 items-center">
        <button onClick={toggleLike} className="text-red-600 font-semibold hover:underline">
          {likeado ? "❤️ Me gusta" : "🤍 Me gusta"} ({likes})
        </button>
        <button onClick={toggleFavorito} className="text-yellow-600 font-semibold hover:underline">
          {favorito ? "⭐ Favorito" : "☆ Marcar favorito"}
        </button>
      </div>

      {/* Comentarios */}
      <div className="mt-8">
        <h3 className="text-xl font-semibold mb-3 text-gray-700">Comentarios</h3>
        {comentarios.length === 0 && (
          <p className="text-sm text-gray-500">Aún no hay comentarios.</p>
        )}
        {comentarios.map((com) => (
          <div key={com.id} className="mb-4 border-b pb-2">
            <p className="text-sm font-semibold">
              {com.usuario?.nombre ?? "Usuario eliminado"}
            </p>
            <p className="text-sm text-gray-700">{com.contenido}</p>
            <p className="text-xs text-gray-400">
              {new Date(com.fecha).toLocaleString()}
            </p>
          </div>
        ))}

        <textarea
          className="w-full border rounded p-2 mt-4"
          rows={3}
          placeholder="Escribe tu comentario..."
          value={nuevoComentario}
          onChange={(e) => setNuevoComentario(e.target.value)}
        />
        <button
          onClick={enviarComentario}
          className="mt-2 px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700"
        >
          Comentar
        </button>
      </div>
    </div>
  );
}
