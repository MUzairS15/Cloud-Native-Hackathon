import QRCode  from "qrcode.react";
import { useState } from "react";

const Code = function () {

    const [sub, setSub] = useState('');
    const [qr, setQr] = useState();
    const handleSubmit = async function(event){
        event.preventDefault();
        const response = await fetch('/api/classcode/addClass',{
            method: 'POST',
            headers:{
                "auth-token": localStorage.getItem('auth-token'),
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body :JSON.stringify({
                sub:sub,
            }) 
        });
        const res = await response.json();
        if(res.success === "success"){
            alert('Posted Successfully');
        } else{
            alert('Some error Occured');
        }
        setQr(res.code[0]);
    }
    let element;
    if(qr){

         element =  <QRCode style={{marginTop:"4rem"}} level ='M' value= {qr} />;
    }
    const handleChange = function(event){  
        setSub(event.target.value);
    }
    return (
        <div>
        <form onSubmit = {handleSubmit}>
            <div className="d-flex flex-row justify-content-center mt-5" >
            <div className="input-group mb-3 mx-3 my-3" style={{width:"30%"}}>
                <div className="input-group-prepend">
                    <span className="input-group-text" id="inputGroup-sizing-default">Subject Name</span>
                </div>
                <input onChange = {handleChange} type="text" className="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" name="subject"/>
            </div>
            </div>
            <button type="submit" className="btn btn-dark my-3">Generate Code</button>
        </form>
        {element}
        
        </div>
    )
}

export default Code;