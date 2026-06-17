import Layout from "../components/Layout";

export default function Perfil() {
    return (
        <Layout>
            <h1>Perfil</h1>

            <div className="card mt-4">
                <div className="card-body">

                    <p>
                        <strong>Usuario:</strong> Wolfdry
                    </p>

                    <p>
                        <strong>Correo:</strong> wolfdry@gathel.com
                    </p>

                    <p>
                        <strong>País:</strong> Costa Rica
                    </p>

                </div>
            </div>
        </Layout>
    );
}