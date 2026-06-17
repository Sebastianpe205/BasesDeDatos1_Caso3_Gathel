import { Link } from "react-router-dom";

function Navbar() {
    return (
        <nav className="navbar navbar-expand-lg navbar-dark bg-dark">
            <div className="container">

                <Link className="navbar-brand" to="/dashboard">
                    Gathel
                </Link>

                <div className="navbar-nav">

                    <Link className="nav-link" to="/dashboard">
                        Dashboard
                    </Link>

                    <Link className="nav-link" to="/propositions">
                        Proposiciones
                    </Link>

                    <Link className="nav-link" to="/predictions">
                        Predicciones
                    </Link>

                    <Link className="nav-link" to="/wallets">
                        Billeteras
                    </Link>

                </div>

            </div>
        </nav>
    );
}

export default Navbar;