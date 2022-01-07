const db = require('../database')

exports.get_stat = async (req, res) => {

    const month = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    const classCode = req.params.code;
   
    const dt = new Date();
    /* Responses by student will be saved in a document,
       Documnet name describes the session. "12dec#21-22"
    */
    const docName = (dt.getDate() + month[dt.getMonth()].substr(0, 3).toLowerCase() + "#" + dt.getHours() + '-' + (dt.getHours() + 1)).split(" ").join("");
    
    const firebaseResponsesDB = db.collection("classroom").doc(classCode).collection("responses").doc(docName).collection("allresponses");
    const resourceDOC = await firebaseResponsesDB.get();

    let totalres = resourceDOC.size;
    let responses = [];
    let correct = 0;
    
    resourceDOC.forEach((doc) => {
        let obj = {
            name: doc.data().Name,
            answered: doc.data().answer,
            PRN: doc.data().PRN,
            email: doc.data().email,
            time: doc.data().time
        }
        if (doc.data().answer) {
            correct++;
        }
        responses.push(obj)
    })
    let wrong = totalres - correct;
    res.json({ 
        responses, "stats": [correct, wrong],
        "success": true
     });
}