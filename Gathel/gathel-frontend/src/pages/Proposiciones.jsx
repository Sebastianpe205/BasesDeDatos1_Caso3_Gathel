import Layout from "../components/Layout";

export default function Proposiciones() {
    return (
        <Layout>
            <h1>Proposiciones</h1>

            <table className="table table-striped mt-4">
                <thead>
                    <tr>
                        <th>Título</th>
                        <th>Estado</th>
                        <th>Fecha Evento</th>
                    </tr>
                </thead>

                <tbody>
                    <tr>
                        <td>El jugador alcanzará nivel 50</td>
                        <td>Activa</td>
                        <td>25/06/2026</td>
                    </tr>

                    <tr>
                        <td>Completará la misión legendaria</td>
                        <td>En votación</td>
                        <td>30/06/2026</td>
                    </tr>
                </tbody>
            </table>
        </Layout>
    );
}