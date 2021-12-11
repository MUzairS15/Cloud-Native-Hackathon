const db = require('../database');
//Questions for LiveQuiz
exports.add_live_question = async function(req, res){
    
    let index = 1;
    let q = req.body.question;
    let code = req.body.code;
    console.log(code)
    for(let ind = 0; ind < q.length; ind++){
        // console.log(q[ind].question)
        const doc = db.collection("classroom").doc(code).collection("questionLive").doc("1");
        await doc.set({
            question: q[ind].question,
            option1 : q[ind].option1,
            option2 : q[ind].option2,
            option3 : q[ind].option3,
            option4 : q[ind].option4,
            score: 2,
            answer : q[ind].correctAns,
            type: req.body.type,
            sub: req.body.sub
        });
};
    res.status(200).json(("success"));
}
//Questions for Question Bank
exports.add_question = async function(req, res, next){

    let q = req.body.question;
    let code = req.body.code;
  console.log("reached")
  for(let ind = 0; ind < q.length; ind++){
      const codecollection = db.collection("classroom").doc(code).collection('currentResource');
      const subjectQue = codecollection.add({
          question: q[ind].question,
          option1 : q[ind].option1,
          option2 : q[ind].option2,
          option3 : q[ind].option3,
          option4 : q[ind].option4,
          correctAns : q[ind].correctAns,
          type: req.body.type,
          sub: req.body.sub
      });
    //   await subjectQue.update({id: subjectQue.id});
    (await subjectQue).set({id: (await subjectQue).id},{merge:true});
    };
    res.status(200).json(("success"));
}

//Get Question from Question Bank

exports.get_question_from_bank = async function(req, res){
    
    let questionBank = [];
    const questionResource = db.collection('classroom').doc(`${req.params.code}`).collection('currentResource');
    const resource = await questionResource.get();
    console.log(resource);
    resource.forEach(doc => {
      let obj = {
        // "id": doc.id,
        "question": doc.data().question,
        "option1" : doc.data().option1,
        "option2" : doc.data().option2,
        "option3" : doc.data().option3,
        "option4" : doc.data().option4,
        "correctAns": doc.data().correctAns,
        "type": doc.data().type,
        "sub": req.body.sub
      }
      console.log(obj);
      questionBank.push(obj);
    });
    res.json({
        "qBank" : questionBank
    })
}