const jwt = require('jsonwebtoken');
const verifyUser = function verifyUser(req, res, next){
    const privateKey = "mynameisuzair";

    let success =true;
    const auth_token = req.header('auth-token');

    if(!auth_token){
        res.status(400).json({error: "Could not authenticate token"});
    }else{

        try{
            const data = jwt.verify(auth_token, privateKey);
            next();
        }
        catch{
            success = false;
            res.status(400).json({success, error: "Could not authenticate token"})
        }
    }
}
module.exports = verifyUser;