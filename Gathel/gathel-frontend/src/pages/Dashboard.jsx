import Layout from "../components/Layout";
import { billeteras } from "../mock/billeteras";
import { proposiciones } from "../mock/proposiciones";
import { predicciones } from "../mock/predicciones";

export default function Dashboard() {

    const puntos =
        billeteras.find(
            b => b.tipo === "Puntos"
        )?.saldo || 0;

    const dinero =
        billeteras.find(
            b => b.tipo === "Dinero"
        )?.saldo || 0;

    return (
        <Layout>

        <h1>Dashboard</h1>

        <p className="text-muted">
            Bienvenido a Gathel.
        </p>

            <div className="row mt-4">

                <div className="col-md-3">
                    <div className="card text-bg-primary">
                        <div className="card-body">
                            <h5>
                                Proposiciones
                            </h5>

                            <h2>
                                {proposiciones.length}
                            </h2>
                        </div>
                    </div>
                </div>

                <div className="col-md-3">
                    <div className="card text-bg-success">
                        <div className="card-body">
                            <h5>
                                Predicciones
                            </h5>

                            <h2>
                                {predicciones.length}
                            </h2>
                        </div>
                    </div>
                </div>

                <div className="col-md-3">
                    <div className="card text-bg-warning">
                        <div className="card-body">
                            <h5>
                                Puntos
                            </h5>

                            <h2>
                                {puntos}
                            </h2>
                        </div>
                    </div>
                </div>

                <div className="col-md-3">
                    <div className="card text-bg-danger">
                        <div className="card-body">
                            <h5>
                                Dinero
                            </h5>

                            <h2>
                                ${dinero}
                            </h2>
                        </div>
                    </div>
                </div>

            </div>

            <div className="card mt-4">

                <div className="card-header">
                    Últimas Proposiciones
                </div>

                <div className="card-body">

                    <table className="table">

                        <thead>
                            <tr>
                                <th>Título</th>
                                <th>Estado</th>
                            </tr>
                        </thead>

                        <tbody>

                            {proposiciones.map((p) => (
                                <tr key={p.id}>
                                    <td>{p.titulo}</td>
                                    <td>{p.estado}</td>
                                </tr>
                            ))}

                        </tbody>

                    </table>

                </div>

            </div>

        </Layout>
    );
}