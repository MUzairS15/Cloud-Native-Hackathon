import { useRef, useState } from "react";
//Add a button to add to resource
const GenQuiz = function (props) {

    const [resource, setResource] = useState([]);
    const {data, handleSubmit, handleAdd} = props.prop;
    let formRef= useRef(null);

    
    const handleClick = async function(){
//send to database
        let formData = [{
            "question" :formRef.current[0].value,
            "option1" : formRef.current[1].value,
            "option2" : formRef.current[2].value,
            "option3" : formRef.current[3].value,
            "option4" : formRef.current[4].value,
            "correctAns": formRef.current[5].value,
        }];
        const code = localStorage.getItem('current-code');
        const sub = localStorage.getItem("current-sub");
        if(code != undefined && sub != undefined) {

            const response = 
            await fetch('/api/quiz/addQuestion', {
                method: 'POST',
                headers: {
                    "auth-token": localStorage.getItem('auth-token'),                
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify({ 
                    "question": formData,
                    "code": code,
                    "sub": sub,
                    "type": "mcq"
                })
            })
            
            const success = await response.json();
            if (success === "success") {
                alert('Posted Successfully');
            } else {
                alert('Some error Occured');
            }
            setResource(resource=>resource.concat(formData))
        } else {
            alert('Please select class from home section');
        } 
    }
    

    return (
        <div className="d-flex flex-grow-1 w-100">
            <form ref = {formRef} id="form" onSubmit={(e) => { handleAdd(e) }} className="d-flex flex-column bd-highlight ml-5 my-3 mx-5" style={{ width: "50%" }}>
                <div className="form-group">
                    <label className="d-flex justify-content-start" htmlFor="exampleFormControlTextarea1">Enter Question Here</label>
                    <textarea name="question" className="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
                </div>
                <input className="form-control my-2" name="option1" type="text" placeholder="Option 1" />
                <input className="form-control my-2" name="option2" type="text" placeholder="Option 2" />
                <input className="form-control my-2" name="option3" type="text" placeholder="Option 3" />
                <input className="form-control my-2" name="option4" type="text" placeholder="Option 4" />
                <input className="form-control my-2" name="correctAns" type="text" placeholder="CA" />
                <div className="d-flex justify-content-around">
                <button type="submit" className="btn btn-dark mt-3 " style={{ width: "max-content", position:"relative", top:"7px"}}>Add</button>
                </div>
            </form>
                <button  onClick={(e)=>{handleClick(e)}} className="btn btn-dark mt-3" style={{ width: "max-content", position: "absolute", left:"-2rem", top: "34rem"}}>Add to Resources</button>
            <div className="d-flex my-6 justify-content-space-around  align-items-start">
                <button onClick={(e)=>{handleSubmit(e)}} className="btn btn-dark mt-3 " style={{ width: "max-content" }}>Send</button>
            </div>
            <div className=" d-flex p-2 bd-highlight flex-wrap justify-content-center w-50 my-auto mx-auto">
                    {data}
            </div>
        </div>
    )
}
export default GenQuiz;
