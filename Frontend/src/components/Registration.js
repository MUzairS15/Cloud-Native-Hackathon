import React, { useState } from 'react'
import '../App.css'
import Login from './Login';
import SignUp from './SignUp';
const Registration = function () {

    const [signUp, isSignUp] = useState(false);
    const onChange = () => {
        isSignUp(!signUp);
        if (state === 'Login') {
            setState("SignUp")
        } else {
            setState("Login")
        }
        document.getElementById("forms").reset();
        console.log("Clicked")
    }
    const [state, setState] = useState("Login")
    const handleSubmit = async function(e) {

        e.preventDefault();
        console.log("Clicked")
        const ele = new FormData(e.target);
        const details = Object.fromEntries(ele);
        console.log(details)
        const response1 = await fetch('/login', {
            method: 'POST',
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                username: details.username,
                password: details.password,
                name: "name"
            })

        })
        const response2 = await response1.json();
        if (response2.error) {
            alert(response2.error)
        } else {
            localStorage.setItem("auth-token", response2.auth_token)
            var hiddenElement = document.createElement('a');
            hiddenElement.href = '/';
            hiddenElement.click();
        }
    }

    const handleCreate = async (e) => {
        e.preventDefault();
        const details = new FormData(e.target);
        const user = Object.fromEntries(details);
        const response1 = await fetch('/createUser', {
            method: 'POST',
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                username: user.email,
                password: user.password,
                name: user.firstname
            })
        })
        const response2 = await response1.json();
        if (response2.error) {
            alert(response2.error)
        }
    }
    if (!signUp) {
        return (
            <>
                <section class="sec1">
                    <div class="title-page">
                        <p>Activity Room</p>
                    </div>
                    <div class="main-inputs login">
                        <div class="choices">
                            <input type="radio" id="radio1" name="tabs" value="login" onChange={onChange} defaultChecked={state === "Login"}></input>
                            <label id="lab1" for="radio1">Login</label>
                            <input type="radio" id="radio2" name="tabs" value="signup" onChange={onChange} defaultChecked={state === "SignUp"}></input>
                            <label id="lab2" for="radio2">Sign Up</label>
                        </div>
                        <Login handleSubmit={handleSubmit} />
                    </div>
                </section>
            </>
        )
    }
    else {
        return (
            <>
                <section class="sec1">
                    <div class="title-page">
                        <p>Activity Room</p>
                    </div>
                    <div class="main-inputs signup">
                    <div class="choices">
                        <input type="radio" id="radio1" name="tabs" value="login" onChange={onChange}></input>
                        <label id="lab1" for="radio1">Login</label>
                        <input type="radio" id="radio2" name="tabs" value="signup" onChange={onChange} ></input>
                        <label id="lab2" for="radio2">Sign Up</label>
                    </div>
                    <SignUp handleCreate = {handleCreate} />
           </div>
            </section>

            </>
        )
    }
}

export default Registration;

