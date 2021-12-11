const db = require('../database');
const CodeGenerator = require('node-code-generator');

exports.generate_codes = async function(req, res){
    var generator = new CodeGenerator();
    var pattern = '#**#**';
    var howMany = 1;
    var options = {};
    let index = 1;
    
    var codes = generator.generateCodes(pattern, howMany, options);
    console.log(codes[0]);
    await db.collection('classroom').doc(codes[0]).set({
       "name":req.body.sub,
    });
    await db.collection('classroom').doc(codes[0]).collection('questionLive').doc('1').set({"type":"mcq"});
    res.json({
        "success": "success",
        "code": codes,
    })
};

exports.get_codes = async function(req, res){
    console.log("reached")
    const docCode =  db.collection('classroom');
    const code = await docCode.get();
    let subjectCodes = []
    code.forEach(doc=>{
        let temp = [] 
        temp.push(doc.data().name);
        temp.push(doc.id)
        subjectCodes.push(temp)
    })
    console.log(subjectCodes[0][1])
    res.json({
        "subcode": subjectCodes
    })
}