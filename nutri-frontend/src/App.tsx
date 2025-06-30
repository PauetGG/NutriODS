import "./App.css";
import { Routes, Route } from "react-router-dom";
import Header from "./components/Header";
import Footer from "./components/Footer";
import HomePage from "./pages/HomePage";
import DietaPage from "./pages/DietaPage";

function App() {
  return (
    <>
      <Header />
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/dieta" element={<DietaPage />} />
      </Routes>
      <Footer />
    </>
  );
}

export default App;
