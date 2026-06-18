import Layout from "../components/Layout";
import { proposiciones } from "../mock/proposiciones";

export default function Proposiciones() {
    return (
        <Layout>
            <h1>Proposiciones</h1>

            <table className="table table-striped mt-4">
                <thead>
                    <tr>
                        <th>Título</th>
                        <th>Estado</th>
                        <th>Fecha</th>
                    </tr>
                </thead>

                <tbody>
                    {proposiciones.map((p) => (
                        <tr key={p.id}>
                            <td>{p.titulo}</td>
                            <td>{p.estado}</td>
                            <td>{p.fecha}</td>
                        </tr>
                    ))}
                </tbody>

            </table>
        </Layout>
    );
}