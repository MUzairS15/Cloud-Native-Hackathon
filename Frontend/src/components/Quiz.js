import { useState } from "react";
import GenQuiz from "./GenQuiz";
import Resources from "./Resources";
import {
    BrowserRouter as Router,
    Switch,
    Route,
} from "react-router-dom";
import { Link } from "react-router-dom";

const Quiz = function () {

    const [dat, setData] = useState([]);

    const handleAdd = function (e) {
        e.preventDefault();
        const q = document.getElementsByTagName("textarea")[0];
        const ele = new FormData(e.target);
        setData(dat => dat.concat(Object.fromEntries(ele)))
    }

    const handleDelete = function (e) {
//del index taken to compare question as 2nd param contains value
        const newDat = dat.filter(function (delIndex, value) {
            if (value == e.target.value)
                return false;
            else return true;
        })
        console.log(newDat);
        setData(newDat);
    }

    const handleSubmit = async function () {

        const response = await fetch('/api/quiz/live/addQuestion', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                "auth-token": localStorage.getItem('auth-token')

            },
            body: JSON.stringify({
                "question": dat,
                "sub": localStorage.getItem("current-sub"),
                "code": localStorage.getItem("current-code"),
                "type": "mcq",
                "score":2
            })
        })
        const success = await response.json();

        if (success === "success") {
            alert('Posted Successfully');
        } else {
            alert('Some error Occured');
        }
    }

    const data = dat.length === 0 ? <div>Please add Questions</div> : (

        (dat.map((question, ind) => (
            <div className="mx-2 my-2" key={ind} style={{ width: "18rem" }}>
                <a href="#" className="list-group-item list-group-item-action active list-group-item-dark">
                    <button type="delete" onClick={(e) => { handleDelete(e) }} className="btn btn-dark" value={ind} style={{ width: "max-content", fontSize: "small", padding: "2px", position: "relative", left: "-7rem", top: "-1rem" }}>Delete</button>
                    <div className="w-100 justify-content-between text-break text-truncate ">
                        <h5 className="mb-1 ">Q.{ind + 1}</h5>
                    </div>
                    <p className="mb-1 text-break text-truncate ">{question.question}</p>
                </a>
            </div>
        )))
    )
        return (
            <div>
                <Router>

                    <div className="sidenav">
                        <nav className="navbar navbar-expand-lg navbar-light bg-light">
                            <div className="collapse navbar-collapse" id="navbarNavAltMarkup">
                                <div className="navbar-nav">
                                    <Link to="/Quiz/genQuiz" className="nav-item nav-link" > Generate Quiz</Link>
                                    <Link to="/Quiz/res" className="nav-item nav-link active" > Resources</Link>
                                </div>
                            </div>
                        </nav>
                    </div>
                    <Switch>
                        <Route exact path="/Quiz/genQuiz">
                            <GenQuiz prop={{data, handleSubmit, handleAdd}} />
                        </Route>
                        <Route exact path="/Quiz/res">
                            <Resources />
                        </Route>
                    </Switch>
                </Router>

            </div>
        )
    
}

export default Quiz;
