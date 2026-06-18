import { Link } from "react-router-dom";
import Header from "./Header";

export default function Layout({ children }) {
    return (
        <div className="d-flex">

            {/* Menú lateral */}
            <div
                className="text-white p-3"
                style={{
                    width: "250px",
                    minHeight: "100vh",
                    backgroundColor: "#1f2937"
                }}
            >
                <h2 className="text-center">
                    Gathel
                </h2>

                <hr />

                <ul className="nav flex-column">

                    <li className="nav-item">
                        <Link
                            className="nav-link text-white"
                            to="/dashboard"
                        >
                            Dashboard
                        </Link>
                    </li>

                    <li className="nav-item">
                        <Link
                            className="nav-link text-white"
                            to="/proposiciones"
                        >
                            Proposiciones
                        </Link>
                    </li>

                    <li className="nav-item">
                        <Link
                            className="nav-link text-white"
                            to="/crear-proposicion"
                        >
                            Crear Proposición
                        </Link>
                    </li>

                    <li className="nav-item">
                        <Link
                            className="nav-link text-white"
                            to="/predicciones"
                        >
                            Predicciones
                        </Link>
                    </li>

                    <li className="nav-item">
                        <Link
                            className="nav-link text-white"
                            to="/crear-prediccion"
                        >
                            Crear Predicción
                        </Link>
                    </li>

                    <li className="nav-item">
                        <Link
                            className="nav-link text-white"
                            to="/billeteras"
                        >
                            Billeteras
                        </Link>
                    </li>

                    <li className="nav-item">
                        <Link
                            className="nav-link text-white"
                            to="/perfil"
                        >
                            Perfil
                        </Link>
                    </li>

                </ul>
            </div>

            {/* Contenido */}
            <div className="flex-grow-1">

                <Header />

                <div className="p-4">
                    {children}
                </div>

            </div>

        </div>
    );
}