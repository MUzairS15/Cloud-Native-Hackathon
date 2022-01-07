import { Link } from "react-router-dom";
function NavBar() {

    return (
        <div className="sidenav">
            <nav className="navbar navbar-expand-lg navbar-light bg-light">
                <div className="collapse navbar-collapse" id="navbarNavAltMarkup">
                    <div className="navbar-nav">
                        <Link to="/" className="nav-item nav-link active" > Home</Link>
                        <Link to="/code" className="nav-item nav-link active" > Code</Link>
                        <Link to="/Quiz/genQuiz" className="nav-item nav-link active" > Quiz</Link>
                        <Link to="/attendance" className="nav-item nav-link active" > Attendance</Link>
                    </div>
                </div>
            </nav>
        </div>
    )
}

export default NavBar;