import Layout from "../components/Layout";

export default function Billeteras() {
    return (
        <Layout>
            <h1>Billeteras</h1>

            <div className="row mt-4">

                <div className="col-md-6">
                    <div className="card">
                        <div className="card-body">
                            <h4>Puntos</h4>
                            <h2>1500</h2>
                        </div>
                    </div>
                </div>

                <div className="col-md-6">
                    <div className="card">
                        <div className="card-body">
                            <h4>Dinero</h4>
                            <h2>$250.00</h2>
                        </div>
                    </div>
                </div>

            </div>
        </Layout>
    );
}