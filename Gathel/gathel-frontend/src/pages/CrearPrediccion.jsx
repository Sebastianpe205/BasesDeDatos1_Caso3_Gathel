import { useState } from "react";
import Layout from "../components/Layout";

export default function CrearPrediccion() {

    const [proposicion, setProposicion] = useState("");
    const [prediccion, setPrediccion] = useState("Si");
    const [tipo, setTipo] = useState("Puntos");
    const [monto, setMonto] = useState("");

    const crearPrediccion = (e) => {
        e.preventDefault();

        console.log({
            proposicion,
            prediccion,
            tipo,
            monto
        });

        alert("Predicción creada (simulada)");
    };

    return (
        <Layout>

            <h1>Crear Predicción</h1>

            <div className="card mt-4">
                <div className="card-body">

                    <form onSubmit={crearPrediccion}>

                        <div className="mb-3">
                            <label className="form-label">
                                Proposición
                            </label>

                            <select
                                className="form-select"
                                value={proposicion}
                                onChange={(e) =>
                                    setProposicion(e.target.value)
                                }
                            >
                                <option value="">
                                    Seleccione una proposición
                                </option>

                                <option value="1">
                                    Alcanzará nivel 50
                                </option>

                                <option value="2">
                                    Ganará el torneo
                                </option>

                            </select>
                        </div>

                        <div className="mb-3">

                            <label className="form-label">
                                Predicción
                            </label>

                            <select
                                className="form-select"
                                value={prediccion}
                                onChange={(e) =>
                                    setPrediccion(e.target.value)
                                }
                            >
                                <option value="Si">Sí</option>
                                <option value="No">No</option>
                            </select>

                        </div>

                        <div className="mb-3">

                            <label className="form-label">
                                Tipo de apuesta
                            </label>

                            <select
                                className="form-select"
                                value={tipo}
                                onChange={(e) =>
                                    setTipo(e.target.value)
                                }
                            >
                                <option value="Puntos">
                                    Puntos
                                </option>

                                <option value="Dinero">
                                    Dinero
                                </option>
                            </select>

                        </div>

                        <div className="mb-3">

                            <label className="form-label">
                                Monto
                            </label>

                            <input
                                type="number"
                                className="form-control"
                                value={monto}
                                onChange={(e) =>
                                    setMonto(e.target.value)
                                }
                            />

                        </div>

                        <button
                            type="submit"
                            className="btn btn-primary"
                        >
                            Crear Predicción
                        </button>

                    </form>

                </div>
            </div>

        </Layout>
    );
}