import Layout from "../components/Layout";
import { perfil } from "../mock/perfil";

export default function Perfil() {

    return (
        <Layout>

            <h1>
                Perfil
            </h1>


            <div className="card mt-4 shadow">

                <div className="card-body">

                    <div className="text-center mb-4">

                        <div
                            className="rounded-circle bg-secondary text-white d-inline-flex justify-content-center align-items-center"
                            style={{
                                width: "100px",
                                height: "100px",
                                fontSize: "40px"
                            }}
                        >
                            👤
                        </div>

                        <h3 className="mt-3">
                            {perfil.displayName}
                        </h3>

                        <span className="badge bg-primary">
                            {perfil.role}
                        </span>

                    </div>


                    <hr />


                    <div className="row">

                        <div className="col-md-6 mb-3">

                            <strong>
                                Usuario
                            </strong>

                            <p>
                                {perfil.username}
                            </p>

                        </div>


                        <div className="col-md-6 mb-3">

                            <strong>
                                Email
                            </strong>

                            <p>
                                {perfil.email}
                            </p>

                        </div>


                        <div className="col-md-6 mb-3">

                            <strong>
                                País
                            </strong>

                            <p>
                                {perfil.country}
                            </p>

                        </div>


                        <div className="col-md-6 mb-3">

                            <strong>
                                Idioma preferido
                            </strong>

                            <p>
                                {perfil.language}
                            </p>

                        </div>

                    </div>


                    <button
                        className="btn btn-primary"
                    >
                        Editar perfil
                    </button>


                </div>

            </div>

        </Layout>
    );
}