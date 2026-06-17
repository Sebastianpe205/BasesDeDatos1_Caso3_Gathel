import { useState } from "react";
import Layout from "../components/Layout";

export default function CrearProposicion() {

    const [titulo, setTitulo] = useState("");
    const [descripcion, setDescripcion] = useState("");
    const [fechaEvento, setFechaEvento] = useState("");

    const crearProposicion = (e) => {
        e.preventDefault();

        console.log({
            titulo,
            descripcion,
            fechaEvento
        });

        alert("Proposición creada (simulada)");
    };

    return (
        <Layout>

            <h1>Crear Proposición</h1>

            <div className="card mt-4">
                <div className="card-body">

                    <form onSubmit={crearProposicion}>

                        <div className="mb-3">
                            <label className="form-label">
                                Título
                            </label>

                            <input
                                type="text"
                                className="form-control"
                                value={titulo}
                                onChange={(e) =>
                                    setTitulo(e.target.value)
                                }
                            />
                        </div>

                        <div className="mb-3">
                            <label className="form-label">
                                Descripción
                            </label>

                            <textarea
                                className="form-control"
                                rows="4"
                                value={descripcion}
                                onChange={(e) =>
                                    setDescripcion(e.target.value)
                                }
                            />
                        </div>

                        <div className="mb-3">
                            <label className="form-label">
                                Fecha del Evento
                            </label>

                            <input
                                type="datetime-local"
                                className="form-control"
                                value={fechaEvento}
                                onChange={(e) =>
                                    setFechaEvento(e.target.value)
                                }
                            />
                        </div>

                        <button
                            type="submit"
                            className="btn btn-success"
                        >
                            Crear Proposición
                        </button>

                    </form>

                </div>
            </div>

        </Layout>
    );
}