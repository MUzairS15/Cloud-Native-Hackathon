import { useEffect, useRef, useState } from "react";
import Responses from './Responses';


const Home = function () {

    const [subjectList, setSubjectList] = useState([]); 
    const [students, setStudents] = useState([]);
    const [qwStat, setqwStat] = useState([]) //if multiple question send then use but right now mobile app doent support this
    const [stat, setStat] = useState(['sasd']);
    // console.log("stat", stat)
    const [responses, setResponses] = useState([''])

    const getResponse = async function fetchResponse() {

    const response2 = await fetch(`/api/responses/getstat/${localStorage.getItem("current-code")}`, {
        headers: {
            "auth-token": localStorage.getItem('auth-token')
        }
    })
    const student = await response2.json();

    setResponses(student.responses);
    setStat(student.stats);
    setqwStat(students.stats)
    }

    const getStudents = async function fetchStudents() {
        const response = await fetch(`/api/students/getStudents/${localStorage.getItem("current-code")}`, {
            headers: {
                "auth-token": localStorage.getItem('auth-token')
            }
        })
    const registeredStudents = await response.json();
       
    setStudents(registeredStudents.users);
    }
    
    async function fetchCodes() {

        const response = await fetch(`/api/classcode/getCodes`, {
            headers: {
                "auth-token": localStorage.getItem('auth-token')
            }
        });
        const code = await response.json();
        setSubjectList(code.subcode);
    }

    useEffect(() => {
        getStudents();
    }, [subjectList]);

    const handleChange = async function (e) {
    
        let sub = e.target.value.split("-")[0].trim();
        let code = e.target.value.split("-")[1].trim();
        localStorage.setItem("current-sub", sub)
        localStorage.setItem("current-code", code)
        getStudents();
    }

    const handleDownload = function () {

        let values = [];
        let keys = [];

        responses.forEach(function (val) {
            values.push(Object.values(val));
            keys.push(Object.keys(val));
        })
        console.log(values);
        console.log(keys);
        var csv = `${keys[0]}\n`;
        console.log(csv)

        values.forEach(function (val) {
            csv += val;
            csv += "\n";
        })
        console.log(csv);
        document.write(csv);
        var hiddenElement = document.createElement('a');
        hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
        hiddenElement.target = '_blank';
        hiddenElement.download = `${localStorage.getItem('current-code')}Response.csv`;
        hiddenElement.click();
        window.location.reload();
    }

    const handleGetResponse = async function () {
       await  getResponse();
    }

    const handleLogOut = function () {

        localStorage.clear();
        var hiddenElement = document.createElement('a');
        hiddenElement.href = '/';
        hiddenElement.click();
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
                    <option defaultValue>Please select</option>
                    {subjectList.map((sub, ind) => (
                        <option key={ind} value1={sub[0], sub[1]} value2={sub[1]} >{sub[0]} - {sub[1]}</option>
                    ))}
                </select>
                <Responses props={{stat, responses}} />
                <div className="d-flex flex-wrap mx-4 my-3">
                    {students.map((student, ind) => (
                        <div key={ind} className="card mx-2 my-1" style={{ width: "18rem" }}>
                            <div className="card-body">
                                <h5 className="card-title">Name: {student.Name}</h5>
                                <p className="card-text">PRN: {student.PRN}</p>
                                <p className="card-text">email: {student.email}</p>
                                <p className="card-text">Subject: {student.roomSubject}</p>
                                <p className="card-text">Score: {student.score}</p>
                                <p className = "carrd-text"> Attendance: {student.Attendance}</p>
                            </div>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    )

}

export default Home;