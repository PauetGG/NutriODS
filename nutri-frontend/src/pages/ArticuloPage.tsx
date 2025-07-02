import { useEffect, useState } from "react";
import { useParams,  } from "react-router-dom";

type Articulo = {
  id: number;
  titulo: string;
  resumen: string;
  contenido: string;
  imagenUrl: string;
  categoria: string;
  autor: string;
  fechaPublicacion: string;
  visible: boolean;
};

export default function ArticuloPage() {
  const { id } = useParams<{ id: string }>();
  const [articulo, setArticulo] = useState<Articulo | null>(null);

  useEffect(() => {
    if (!id) return;

    fetch(`http://localhost:8080/api/articulos/${id}`)
      .then((res) => res.json())
      .then((data) => setArticulo(data))
      .catch((err) => console.error("Error al cargar artículo:", err));
  }, [id]);

  if (!articulo) {
    return <div className="p-6 text-center text-gray-600">Cargando artículo...</div>;
  }

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
      <p className="text-lg text-gray-800 leading-relaxed mt-4 whitespace-pre-wrap">{articulo.contenido}</p>
    </div>
  );
}
