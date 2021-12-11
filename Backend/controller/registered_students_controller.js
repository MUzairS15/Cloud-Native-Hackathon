const db = require('../database');
exports.registered_students = async function(req, res){

    const registeredUsers = await db.collection("users").where('roomCode', '==', req.params.code).get();
    let enrolled = [];
    registeredUsers.forEach(regUser => {
        let subject = regUser.data().roomSubject
        let temp = {
            Name: regUser.data().Name,
            PRN: regUser.data().PRN,
            email: regUser.data().Email,
            roomSubject: regUser.data().roomSubject,
            score: regUser.data().scores[subject],
            Attendance: regUser.data().isAttendingClass ? "Present" : "Absent"  
        }
        enrolled.push(temp); 
    });
    res.json({
        "users": enrolled
    })
}