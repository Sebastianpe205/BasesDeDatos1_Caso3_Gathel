import { Link } from "react-router-dom";

export default function Layout({ children }) {
    return (
        <div className="d-flex">
            <div
                className="bg-dark text-white p-3"
                style={{
                    width: "250px",
                    minHeight: "100vh"
                }}
            >
                <h3>Gathel</h3>

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

            <div className="flex-grow-1 p-4">
                {children}
            </div>
        </div>
    );
}