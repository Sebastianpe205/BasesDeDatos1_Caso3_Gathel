import { BrowserRouter, Routes, Route } from "react-router-dom";

import Login from "../pages/Login";
import Dashboard from "../pages/Dashboard";
import Proposiciones from "../pages/Proposiciones";
import CrearProposicion from "../pages/CrearProposicion";
import Predicciones from "../pages/Predicciones";
import CrearPrediccion from "../pages/CrearPrediccion";
import Billeteras from "../pages/Billeteras";
import Perfil from "../pages/Perfil";
import NotFound from "../pages/NotFound";


export default function AppRoutes() {
    return (
        <BrowserRouter>
            <Routes>
                <Route path="/" element={<Login />} />
                <Route path="/dashboard" element={<Dashboard />} />
                <Route path="/proposiciones" element={<Proposiciones />} />
                <Route path="/predicciones" element={<Predicciones />} />
                <Route path="/billeteras" element={<Billeteras />} />
                <Route path="/perfil" element={<Perfil />} />
                <Route path="/crear-proposicion" element={<CrearProposicion />} />
                <Route path="/crear-prediccion" element={<CrearPrediccion />} />
                <Route path="*" element={<NotFound />} />
            </Routes>
        </BrowserRouter>
    );
}