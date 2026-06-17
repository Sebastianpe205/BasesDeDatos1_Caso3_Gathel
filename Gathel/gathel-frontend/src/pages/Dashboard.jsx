import Layout from "../components/Layout";

export default function Dashboard() {
    return (
        <Layout>
            <h1>Dashboard</h1>

            <div className="row mt-4">
                <div className="col-md-4">
                    <div className="card">
                        <div className="card-body">
                            <h5>Proposiciones Activas</h5>
                            <h2>12</h2>
                        </div>
                    </div>
                </div>

                <div className="col-md-4">
                    <div className="card">
                        <div className="card-body">
                            <h5>Predicciones</h5>
                            <h2>34</h2>
                        </div>
                    </div>
                </div>

                <div className="col-md-4">
                    <div className="card">
                        <div className="card-body">
                            <h5>Puntos Disponibles</h5>
                            <h2>1500</h2>
                        </div>
                    </div>
                </div>
            </div>
        </Layout>
    );
}