import QRCode from "qrcode.react";
import { useEffect, useState } from "react";


const Attendance = function () {

    let timer;
    const [time, setTime] = useState({ current: "" });
        useEffect(()=>{
            timer =  setTimeout(() => {
        let dt = new Date();
        let time = dt.getTime();
        setTime({current: ((time / 1000)).toString()});    
    }, 10000)
       return ()=>clearTimeout(timer);
   })

    return (
        <div className="d-flex flex-column align-items-center ">
            <h3 className="my-4">Scan QR to mark your attendance</h3>
            <QRCode style={{ marginTop: "4rem" }} level='M' value={time.current} />
        </div>
    )
}

export default Attendance;