import { Link } from "react-router-dom";
const NavBar = function () {

    return (
        <div className="sidenav">
            <nav className="navbar navbar-expand-lg navbar-light bg-light">
                <div className="collapse navbar-collapse" id="navbarNavAltMarkup">
                    <div className="navbar-nav">
                        <Link to="/" className="nav-item nav-link" > Home</Link>
                        <Link to="/code" className="nav-item nav-link active" > Code</Link>
                        <Link to="/Quiz/genQuiz" className="nav-item nav-link" > Quiz</Link>
                        <Link to="/attendance" className="nav-item nav-link" > Attendance</Link>
                    </div>
                </div>
            </nav>
        </div>
    )
}

export default NavBar;