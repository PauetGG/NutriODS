import React from "react";

type Receta = {
  id: number;
  nombre: string;
  imagen: string;
  ingredientes: string;
  preparacion: string;
  beneficios: string;
};

const recetas: Receta[] = [
  {
    id: 1,
    nombre: "Ensalada Proteica",
    imagen: "https://tn.com.ar/resizer/v2/una-ensalada-muy-proteica-foto-adobe-stock-BAIRYD5PN5ANHEVOPMQDOCBV44.png?auth=b00cb6db94814ecfd16285648dce25a54f56579aa4d72a1009346ad01de7d8b5&width=1440",
    ingredientes: "Lechuga, pollo, tomate, aguacate, aceite de oliva",
    preparacion: "Mezclar todos los ingredientes y aderezar con aceite de oliva.",
    beneficios: "Alta en proteínas, buena para el músculo.",
  },
  {
    id: 2,
    nombre: "Smoothie Verde",
    imagen: "https://www.hazteveg.com/img/recipes/full/201612/R03-65246.jpg",
    ingredientes: "Espinaca, plátano, leche de almendra, chía",
    preparacion: "Licuar todos los ingredientes.",
    beneficios: "Detox y energía natural.",
  },
  {
    id: 3,
    nombre: "Bowl Vegano",
    imagen: "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=800&q=80",
    ingredientes: "Quinoa, garbanzos, zanahoria, aguacate, tahini",
    preparacion: "Servir en capas y agregar la salsa.",
    beneficios: "Proteínas vegetales completas.",
  },
  {
    id: 4,
    nombre: "Pescado al Horno",
    imagen: "https://mundocancer.org/wp-content/uploads/2024/10/31.png",
    ingredientes: "Filete de pescado, verduras, limón",
    preparacion: "Hornear todo junto 20 min a 180°C.",
    beneficios: "Omega-3 y baja grasa.",
  },
  {
    id: 5,
    nombre: "Avena con Frutas",
    imagen: "https://deliciaskitchen.b-cdn.net/wp-content/uploads/2021/11/gachas-de-avena-porridge-1170x781.webp",
    ingredientes: "Avena, leche, plátano, fresas, miel",
    preparacion: "Cocer la avena y decorar con frutas.",
    beneficios: "Fibra y energía sostenida.",
  },
  {
    id: 6,
    nombre: "Tacos Saludables",
    imagen: "https://www.dir.cat/blog/wp-content/uploads/2017/11/receta-taco-verduras-pollo.jpg",
    ingredientes: "Tortilla integral, pollo, vegetales",
    preparacion: "Rellenar tortillas con los ingredientes cocidos.",
    beneficios: "Bajo en calorías y delicioso.",
  },
  {
    id: 7,
    nombre: "Yogur con Granola",
    imagen: "https://storage.googleapis.com/avena-recipes-v2/2024/08/1723587839578.jpeg",
    ingredientes: "Yogur natural, granola, frutos rojos",
    preparacion: "Servir en capas dentro de un vaso.",
    beneficios: "Probióticos y fibra.",
  },
  {
    id: 8,
    nombre: "Crema de Calabaza",
    imagen: "https://paulasapron.com/wp-content/uploads/2022/11/Crema-de-Calabaza-Asada-con-Picatostes-de-Gruyere-2-scaled.avif",
    ingredientes: "Calabaza, cebolla, ajo, caldo, aceite de oliva",
    preparacion: "Hervir y licuar todo hasta obtener una crema suave.",
    beneficios: "Ligera, digestiva y reconfortante.",
  },
  {
    id: 9,
    nombre: "Wok de Verduras",
    imagen: "https://assets.unileversolutions.com/recipes-v3/40868-default.jpg?im=AspectCrop=(720,459);Resize=(720,459)",
    ingredientes: "Brócoli, zanahoria, pimiento, soja, jengibre",
    preparacion: "Saltear en wok a fuego alto con salsa de soja.",
    beneficios: "Alto en fibra, vitaminas y antioxidantes.",
  },
  {
    id: 10,
    nombre: "Panqueques de Avena",
    imagen: "https://storage.googleapis.com/fitia_public_images/recipes%2FGR-R-V-00000831_k8b67u4vkena0cm06rvptggk_large.jpeg",
    ingredientes: "Avena molida, huevo, plátano, leche",
    preparacion: "Mezclar todo y cocinar en sartén antiadherente.",
    beneficios: "Sin harinas refinadas, ideal para desayuno.",
  },
  {
    id: 11,
    nombre: "Sopa Detox",
    imagen: "https://shawellness.com/shamagazine/wp-content/uploads/2018/01/iStock-863861056-724x450.jpg",
    ingredientes: "Apio, zanahoria, cebolla, jengibre, cúrcuma",
    preparacion: "Hervir todo 25 minutos y licuar.",
    beneficios: "Desintoxicante y antiinflamatoria.",
  },
  {
    id: 12,
    nombre: "Ensalada Mediterránea",
    imagen: "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=800&q=80",
    ingredientes: "Pepino, tomate cherry, aceitunas, queso feta",
    preparacion: "Mezclar todo con orégano y aceite de oliva.",
    beneficios: "Rica en grasas buenas y antioxidantes.",
  },
];

const Recetario = () => {
  return (
    <div
      className="min-h-screen p-10"
      style={{
        background: "linear-gradient(135deg, #e0f7fa, #f1f8e9)",
      }}
    >
      <h2
        className="text-5xl font-extrabold mb-10 text-center"
        style={{
          fontFamily: "'Playfair Display', serif",
          color: "#2c3e50", // azul oscuro elegante
          letterSpacing: "0.05em",
          textShadow: "1px 1px 2px rgba(44, 62, 80, 0.3)",
        }}
      >
        Recetario
      </h2>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-10">
        {recetas.map((receta) => (
          <div
            key={receta.id}
            className="relative group rounded-2xl overflow-hidden shadow-2xl border border-white/30 bg-white/10 backdrop-blur-lg transition-all duration-500 hover:scale-105"
          >
            <img
              src={receta.imagen}
              alt={receta.nombre}
              className="w-full h-64 object-cover transition-opacity duration-500 group-hover:opacity-0"
            />
            <div className="absolute inset-0 p-6 opacity-0 group-hover:opacity-100 transition-opacity duration-500 text-white bg-black/60 overflow-y-auto">
              <h3 className="text-2xl font-semibold mb-2">{receta.nombre}</h3>
              <p className="mb-1">
                <strong>🥗 Ingredientes:</strong> {receta.ingredientes}
              </p>
              <p className="mb-1">
                <strong>👩‍🍳 Preparación:</strong> {receta.preparacion}
              </p>
              <p className="mt-2 italic text-green-200">
                <strong>💡 Beneficios:</strong> {receta.beneficios}
              </p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Recetario;
