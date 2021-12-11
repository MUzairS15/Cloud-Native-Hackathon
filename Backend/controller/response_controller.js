const db = require('../database')

exports.get_stat = async (req, res) => {

    const month = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    const classCode = req.params.code;
    console.log("dfsfdsfdf")
    const dt = new Date();
    const docName = (dt.getDate() + month[dt.getMonth()].substr(0, 3).toLowerCase() + "#" + 10 + '-' + (11)).split(" ").join("");
    console.log(docName);
    // const questionID = await db.collection("classroom").doc(classCode).collection("questionLive").get();

    // ID = []
    // questionID.forEach((doc) => {
    //     let obj = {
    //         id: doc.id,
    //         question: doc.data().question
    //     }
    //     ID.push(obj);
    // })

    const firebaseResponsesDB = db.collection("classroom").doc(classCode).collection("responses").doc(docName).collection("allresponses");
    const resourceDOC = await firebaseResponsesDB.get();
    // console.log(resourceDOC.size;
    let totalres = resourceDOC.size;
    let stats = new Array(resourceDOC.size).fill(0);
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
    res.json({ responses, "stats": [correct, wrong] });
}