import React from "react"
import PropTypes from 'prop-types'

function Login (props) {

    const {handleSubmit} = props
    return (
        <>
            <form id="forms" onSubmit={(e) => { handleSubmit(e) }}>
                <div className="form-elem">
                    <div className="svg-bind">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" className="bi bi-person-circle" viewBox="0 0 16 16">
                            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z" />
                            <path fillRule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z" />
                        </svg>
                    </div>
                    <input type="text" placeholder="Username" autoComplete="off" name="username"
                        id="username"></input>
                </div>
                <div className="form-elem">
                    <div className="svg-bind">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" className="bi bi-lock" viewBox="0 0 16 16">
                            <path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2zM5 8h6a1 1 0 0 1 1 1v5a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V9a1 1 0 0 1 1-1z" />
                        </svg>
                    </div>
                    <input type="password" placeholder="Password" autoComplete="off" name="password"
                        id="password"></input>
                </div>
                <div className="form-elem">
                    <button type="submit" > Log in</button>
                </div>
            </form>
        </>
    )
}

Login.propTypes = {
    props: PropTypes.func
}
export default Login