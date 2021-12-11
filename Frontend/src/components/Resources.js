import { useEffect, useState } from "react";

const Resources = function () {
    let queSet = new Set(); //set of question to be sent to Question Bank
    // To store question from Question Bank to display to user
    const [question, setQ] = useState([]); 
    useEffect(() => {
        async function Questions() {
            const response = await fetch(`/api/quiz/getQuestion/${localStorage.getItem("current-code")}`, {
                headers: {
                    "auth-token": localStorage.getItem('auth-token')
                }
            });
            let questionArray = await response.json();
            setQ(questionArray.qBank);
        }
        Questions();
    }, [])

    const handleAdd = function(index){
        const element = document.getElementById(index)
        if(!queSet.has(question[index])) {
            queSet.add(question[index]);
            element.style.boxShadow = '2px 2px 1px 1px black, -2px -2px 1px 1px black'
        } else {
            queSet.delete(question[index])
            element.style.boxShadow = null
        }
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
                "question": queSet,
                "sub": localStorage.getItem("current-sub"),
                "code": localStorage.getItem("current-code"),
                "type": "mcq"
            })
        })

        const success = await response.json();
        if (success === "success") {
            alert('Posted Successfully');
        } else {
            alert('Some error Occured');
        }
}

return (
    <div>
        <div className=" d-flex justify-content-end mx-3" >
            <button type="submit" onClick={handleSubmit} className=" d-flex btn btn-dark mt-3 " style={{ width: "max-content", "left": "-9rem" }}>Send</button>
        </div>
        <div className="d-flex flex-wrap" >
            {question.map((question, ind) => (
                <div key={ind} className="card mx-3 my-1 " style={{ width: "max-content" }} >
                    <div id={ind} className="card-body flex-wrap" style={{ width: "18rem" }} onClick ={()=>{handleAdd(ind)}}>
                        <button style={{ position: "relative", left: "109px", top: "-16px" }}>more</button>
                        <p style={{ textAlign: "start" }}>Q.{ind + 1}</p>
                        <h5>{question.question}</h5>
                    </div>
                </div>))}
        </div>
    </div>
)
}

export default Resources;