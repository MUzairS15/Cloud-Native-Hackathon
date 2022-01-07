import { useEffect, useState } from "react";
import { useHistory } from 'react-router-dom';
import Responses from './Responses';


function Home() {

    const [subjectList, setSubjectList] = useState([]);
    const [students, setStudents] = useState([]);
    const [stat, setStat] = useState([]);
    const [responses, setResponses] = useState([])
    const history = useHistory();
    let defaultValue = "Please select class code";

    useEffect(() => {
        getStudents();
    }, [subjectList]);

    const selectedCode = localStorage.getItem("current-code");
    const selectedSubject = localStorage.getItem("current-sub");

    // Get responses of students and create statistics (Responses component)
    const getResponse = async function fetchResponse() {
        if (selectedCode !== null) {
            const response2 = await fetch(`/api/responses/getstat/${selectedCode}`, {
                headers: {
                    "auth-token": localStorage.getItem('auth-token')
                }
            })
            const student = await response2.json();

            setResponses(student.responses);
            setStat(student.stats);
        }
    }

    const getStudents = async function fetchStudents() {
        if (selectedCode !== null) {
            const response = await fetch(`/api/students/getStudents/${selectedCode}`, {
                headers: {
                    "auth-token": localStorage.getItem('auth-token')
                }
            })
            const registeredStudents = await response.json();
            setStudents(registeredStudents.users);
        }
    }
    const fetchCodes = async function () {

        const response = await fetch(`/api/classcode/getCodes`, {
            headers: {
                "auth-token": localStorage.getItem('auth-token')
            }
        });
        const code = await response.json();
        setSubjectList(code.subcode);
    }


    const handleChange = async function (e) {
        let sub = e.target.value.split("-")[0].trim();
        let code = e.target.value.split("-")[1].trim();
        localStorage.setItem("current-sub", sub)
        localStorage.setItem("current-code", code)
        getStudents();
    }

    const handleDownload = function () {

        /* keys currently will have 'Name', 'Answered' (Attempted or not), 'PRN',
         * 'Email', 'Time' (Time taken to answer each question).
        */
        let keys = [];

        let values = [];

        responses.forEach(function (val) {
            values.push(Object.values(val));
            keys.push(Object.keys(val));
        })

        var csv = `${keys[0]}\n`;

        // Parse the responses in valid CSV format
        values.forEach((val) => {
            csv += val;
            csv += "\n";
        })
        document.write(csv);

        // Button to download session record in csv format.
        var hiddenElement = document.createElement('a');
        hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
        hiddenElement.target = '_blank';
        hiddenElement.download = `${selectedCode}Response.csv`;
        hiddenElement.click();
        window.location.reload();
    }

    const handleGetResponse = async function () {
        await getResponse();
    }

    const handleLogOut = function () {
        localStorage.clear();
        history.push('/');
    }
    
    return (
        <div>
            <div className="d-flex justify-content-end">
                <button onClick={handleLogOut} className="mx-3 btn btn-dark mt-3" >LogOut</button>
                <button onClick={handleGetResponse} className="mx-3 btn btn-dark mt-3"  >GetResponse</button>
                <button target="_blank" onClick={handleDownload} className="mx-3 btn btn-dark mt-3"  >Download</button>
            </div>
            <div className="d-flex flex-column align-items-center">
                <select id="select" onClick={fetchCodes} onChange={(e) => { handleChange(e) }} className="form-select my-3" aria-label="Default select example" style={{ width: "50%" }}>
                    <option >{defaultValue}</option>
                    {subjectList.length > 0 &&
                        subjectList.map((sub, ind) => (
                            <option key={ind} >{sub[0]} - {sub[1]}</option>
                        ))
                    }
                </select>
                <Responses props={{ stat, responses }} />
                <div className="d-flex flex-wrap mx-4 my-3">
                    {students.map((student, ind) => (
                        <div key={ind} className="card mx-2 my-1" style={{ width: "18rem" }}>
                            <div className="card-body">
                                <h5 className="card-title">Name: {student.Name}</h5>
                                <p className="card-text">PRN: {student.PRN}</p>
                                <p className="card-text">email: {student.email}</p>
                                <p className="card-text">Subject: {student.roomSubject}</p>
                                <p className="card-text">Score: {student.score}</p>
                                <p className="carrd-text"> Attendance: {student.Attendance}</p>
                            </div>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    )

}

export default Home;