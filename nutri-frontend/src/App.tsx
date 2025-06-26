import "./App.css";
import { Routes, Route } from "react-router-dom";

import Header from "./components/Header";
import Footer from "./components/Footer";

import HomePage from "./pages/HomePage";
// Si tienes otras páginas, impórtalas aquí
// import RecetasPage from "./pages/RecetasPage";
// import ForoPage from "./pages/ForoPage";
// import EducacionPage from "./pages/EducacionPage";

function App() {
  return (
    <>
      <Header />
      <Routes>
        <Route path="/" element={<HomePage />} />
        {/* Añadir otras rutas si las tienes, por ejemplo:
        <Route path="/recetas" element={<RecetasPage />} />
        <Route path="/foro" element={<ForoPage />} />
        <Route path="/educacion" element={<EducacionPage />} /> */}
      </Routes>
      <Footer />
    </>
  );
}

export default App;
