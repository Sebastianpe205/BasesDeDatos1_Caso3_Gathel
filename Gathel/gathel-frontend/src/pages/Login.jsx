import { useState } from "react";
import { useNavigate } from "react-router-dom";

export default function Login() {

    const navigate = useNavigate();

    const [usuario, setUsuario] = useState("");
    const [password, setPassword] = useState("");

    /*const handleLogin = (e) => {
        e.preventDefault();

        console.log({
            usuario,
            password
        });

        navigate("/dashboard");
    };*/

    const handleLogin = (e) => {
        e.preventDefault();

        navigate("/dashboard");
    };

    return (
        <div
            className="container-fluid vh-100 d-flex justify-content-center align-items-center bg-light"
        >

            <div
                className="card shadow"
                style={{ width: "400px" }}
            >

                <div className="card-body p-4">

                    <div className="text-center mb-4">

                        <h1>
                            Gathel
                        </h1>

                        <p className="text-muted">
                            Plataforma de predicciones
                        </p>

                    </div>

                    <form onSubmit={handleLogin}>

                        <div className="mb-3">

                            <label className="form-label">
                                Usuario
                            </label>

                            <input
                                type="text"
                                className="form-control"
                                value={usuario}
                                onChange={(e) =>
                                    setUsuario(e.target.value)
                                }
                                required
                            />

                        </div>

                        <div className="mb-4">

                            <label className="form-label">
                                Contraseña
                            </label>

                            <input
                                type="password"
                                className="form-control"
                                value={password}
                                onChange={(e) =>
                                    setPassword(e.target.value)
                                }
                                required
                            />

                        </div>

                        <button
                            type="submit"
                            className="btn btn-primary w-100"
                        >
                            Iniciar Sesión
                        </button>

                    </form>

                </div>

            </div>

        </div>
    );
}