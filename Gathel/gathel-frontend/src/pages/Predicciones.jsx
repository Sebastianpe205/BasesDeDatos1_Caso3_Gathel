import Layout from "../components/Layout";

export default function Predicciones() {
    return (
        <Layout>
            <h1>Predicciones</h1>

            <table className="table table-bordered mt-4">
                <thead>
                    <tr>
                        <th>Proposición</th>
                        <th>Predicción</th>
                        <th>Tipo</th>
                    </tr>
                </thead>

                <tbody>
                    <tr>
                        <td>Alcanzará nivel 50</td>
                        <td>Sí</td>
                        <td>Puntos</td>
                    </tr>

                    <tr>
                        <td>Ganará el torneo</td>
                        <td>No</td>
                        <td>Dinero</td>
                    </tr>
                </tbody>
            </table>
        </Layout>
    );
}