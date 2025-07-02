import "./App.css";
import { Routes, Route } from "react-router-dom";
import Header from "./components/Header";
import Footer from "./components/Footer";
import HomePage from "./pages/HomePage";
import DietaPage from "./pages/DietaPage";
import SeguimientoPage from "./pages/SeguimientoPage";
import GlosarioPage from "./pages/GlosarioPage";
import MultimediaPage from "./pages/MultimediaPage";
import ArticulosPage from "./pages/ArticulosPage";
import PerfilPage from "./pages/PerfilPage";
import ArticuloPage from "./pages/ArticuloPage";

function App() {
  return (
    <>
      <Header />
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/dieta" element={<DietaPage />} />
        <Route path="/seguimiento/:dietaId" element={<SeguimientoPage />} />
        <Route path="/glosario" element={<GlosarioPage />} />
        <Route path="/multimedia" element={<MultimediaPage />} />
        <Route path="/articulos" element={<ArticulosPage />} />
        <Route path="/perfil" element={<PerfilPage />} />
        <Route path="/articulo/:id" element={<ArticuloPage />} />
      </Routes>
      <Footer />
    </>
  );
}

export default App;
