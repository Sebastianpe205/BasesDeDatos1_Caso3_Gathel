import { useNavigate } from "react-router-dom";

export default function Header() {

    const navigate = useNavigate();

    return (
        <div
            className="d-flex justify-content-between align-items-center bg-white border-bottom px-4 py-3"
        >
            <div>
                <h4 className="mb-0">
                    Gathel
                </h4>
            </div>

            <div className="d-flex align-items-center">

                <span className="me-3">
                    Wolfdry
                </span>

                <button
                    className="btn btn-outline-danger btn-sm"
                    onClick={() => navigate("/")}
                >
                    Cerrar sesión
                </button>

            </div>
        </div>
    );
}