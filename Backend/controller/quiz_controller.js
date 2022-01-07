const db = require('../database');

/*  Questions for LiveQuiz: 
    Currently, Android App doesn't support recieving multiple questions for Quiz, hence name of doc "1" is set. 
    Backend and dashboard supports sending multiple questions, when support is ready from app, 'add_live_question' needs to be refactored.
*/
exports.add_live_question = async function(req, res){
    
    let q = req.body.question;
    let code = req.body.code;
    for(let ind = 0; ind < q.length; ind++){
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

/*
    Questions for Question Bank.
    Facilitator can add question related to respective Subject during their free time and during classes can send directly from Question Bank.
*/
exports.add_question = async function(req, res, next){

    let que = req.body.question;
    let code = req.body.code;
  for(let ind = 0; ind < que.length; ind++){
      const codecollection = db.collection("classroom").doc(code).collection('currentResource');
      const subjectQue = codecollection.add({
          question: que[ind].question,
          option1 : que[ind].option1,
          option2 : que[ind].option2,
          option3 : que[ind].option3,
          option4 : que[ind].option4,
          correctAns : que[ind].correctAns,
          type: req.body.type,
          sub: req.body.sub
      });
    (await subjectQue).set({id: (await subjectQue).id},{merge:true});
    };
    res.status(200).json({
        "success": true
    });
}

//Get Question from Question Bank

exports.get_question_from_bank = async function(req, res){
    
    let questionBank = [];
    const questionResource = db.collection('classroom').doc(`${req.params.code}`).collection('currentResource');
    const resource = await questionResource.get();
    resource.forEach(doc => {
      let obj = {
        "question": doc.data().question,
        "option1" : doc.data().option1,
        "option2" : doc.data().option2,
        "option3" : doc.data().option3,
        "option4" : doc.data().option4,
        "correctAns": doc.data().correctAns,
        "type": doc.data().type,
        "sub": req.body.sub
      }
      questionBank.push(obj);
    });
    res.json({
        "qBank" : questionBank,
        "success": true
    })
}