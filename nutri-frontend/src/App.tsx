import "./App.css";
import { Routes, Route } from "react-router-dom";
import Header from "./components/Header";
import Footer from "./components/Footer";

import HomePage from "./pages/HomePage";
import DietaPage from "./pages/DietaPage";
import GlosarioPage from "./pages/GlosarioPage";
import MultimediaPage from "./pages/MultimediaPage";
import ArticulosPage from "./pages/ArticulosPage";
import PerfilPage from "./pages/PerfilPage";
import ArticuloPage from "./pages/ArticuloPage";

import SeguimientoLayout from "./layouts/SeguimientoLayout"; 
import CalendarPage from "./pages/CalendarPage"; 
import HabitosPage from "./pages/HabitosPage";
import ProgresoPage from "./pages/ProgresoPage";
import EstadisticasPage from "./pages/EstadisticasPage";
import DashboardPage from "./pages/DashboardPage";

function App() {
  return (
    <>
      <Header />
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/dieta" element={<DietaPage />} />
        <Route path="/glosario" element={<GlosarioPage />} />
        <Route path="/multimedia" element={<MultimediaPage />} />
        <Route path="/articulos" element={<ArticulosPage />} />
        <Route path="/perfil" element={<PerfilPage />} />
        <Route path="/articulo/:id" element={<ArticuloPage />} />

        {/* 🔥 Rutas anidadas para el seguimiento */}
       <Route path="/seguimiento/:dietaId" element={<SeguimientoLayout />}>
          <Route path="dashboard" element={<DashboardPage />} />
          <Route path="calendar" element={<CalendarPage />} />
          <Route path="progreso" element={<ProgresoPage />} />
          <Route path="habitos" element={<HabitosPage />} />
          <Route path="estadisticas" element={<EstadisticasPage />} />
        </Route>

      </Routes>
      <Footer />
    </>
  );
}

export default App;
