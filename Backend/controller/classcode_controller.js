const db = require('../database');
const {handleAsyncError} = require('../middleware/error');

const CodeGenerator = require('node-code-generator');

exports.generate_codes = async function(req, res, next){
    
    const alreadyGeneratedCodes = await db.collection('classroom').get();
    let prevCodes = []
    alreadyGeneratedCodes.forEach((code)=>{
        prevCodes.push(code.id)
    })

    var howMany = 1;
    var generator = new CodeGenerator();

    /* '#' with a single numeric character
     *  '*' with a single alphanumeric character (excluding ambiguous letters and numbers)
     */
    var pattern = '#**#**';

    // existingCodesLoader: function that returns an array of previously generated codes for the 'pattern' to avoid duplicates
    var options = {
        existingCodesLoader: ()=> prevCodes
    };
    
    let codes;
    // Generate an array of random unique codes according to the provided pattern:
    codes = generator.generateCodes(pattern, howMany, options);
    
    await db.collection('classroom').doc(codes[0]).set({
        "name":req.body.sub,
    });
    await db.collection('classroom').doc(codes[0]).collection('questionLive').doc('1').set({"type":"mcq"});
    res.json({
        "success":true,
        "code": codes,
    })
};

exports.get_codes = async function(req, res, next){
    const docCode =  db.collection('classroom');
    const code = await docCode.get();
    let subjectCodes = []
    code.forEach(doc=>{
        let data = [] 
        data.push(doc.data().name);
        data.push(doc.id)
        subjectCodes.push(data)
    })
    res.json({
        "subcode": subjectCodes,
        "success": true
    })
}