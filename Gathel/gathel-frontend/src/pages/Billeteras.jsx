import Layout from "../components/Layout";
import { billeteras } from "../mock/billeteras";

export default function Billeteras() {

    return (
        <Layout>

            <h1>Billeteras</h1>

            <div className="row mt-4">

                {billeteras.map((b) => (

                    <div
                        key={b.tipo}
                        className="col-md-6"
                    >
                        <div className="card">
                            <div className="card-body">

                                <h4>{b.tipo}</h4>

                                <h2>
                                    {b.saldo}
                                </h2>

                            </div>
                        </div>
                    </div>

                ))}

            </div>

        </Layout>
    );
}