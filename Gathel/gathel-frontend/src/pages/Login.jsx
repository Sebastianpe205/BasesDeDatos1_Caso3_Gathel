import { useNavigate } from "react-router-dom";

export default function Login() {
    const navigate = useNavigate();

    return (
        <div className="container vh-100 d-flex justify-content-center align-items-center">
            <div
                className="card shadow p-4"
                style={{ width: "400px" }}
            >
                <h2 className="text-center mb-4">
                    Gathel
                </h2>

                <div className="mb-3">
                    <label className="form-label">
                        Usuario
                    </label>

                    <input
                        type="text"
                        className="form-control"
                        placeholder="Ingrese su usuario"
                    />
                </div>

                <div className="mb-3">
                    <label className="form-label">
                        Contraseña
                    </label>

                    <input
                        type="password"
                        className="form-control"
                        placeholder="Ingrese su contraseña"
                    />
                </div>

                <button
                    className="btn btn-primary w-100"
                    onClick={() => navigate("/dashboard")}
                >
                    Iniciar sesión
                </button>
            </div>
        </div>
    );
}