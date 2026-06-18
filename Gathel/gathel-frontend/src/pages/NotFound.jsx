import { Link } from "react-router-dom";

export default function NotFound() {
    return (
        <div className="container text-center mt-5">

            <h1 className="display-1">
                404
            </h1>

            <h3>
                Página no encontrada
            </h3>

            <p>
                La página que buscas no existe.
            </p>

            <Link
                to="/dashboard"
                className="btn btn-primary"
            >
                Volver al Dashboard
            </Link>

        </div>
    );
}