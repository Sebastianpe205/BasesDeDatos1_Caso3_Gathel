import Layout from "../components/Layout";
import { predicciones } from "../mock/predicciones";

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

                    {predicciones.map((p) => (
                        <tr key={p.id}>
                            <td>{p.proposicion}</td>
                            <td>{p.respuesta}</td>
                            <td>{p.tipo}</td>
                        </tr>
                    ))}

                </tbody>

            </table>

        </Layout>
    );
}