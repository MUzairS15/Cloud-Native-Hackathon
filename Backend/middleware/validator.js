const { validationResult, check } = require('express-validator');

const validateBody = async (req, res, next) =>{
    await check('username').isEmail().run(req)
    await check('password',
                "Password should be at least 8 character and contain at least one uppercase, one lower case and atleast one special character.")
                .isLength({min:8})
                .matches("/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$/", "i")
                .run(req);
    
    const errors =  validationResult(req);
    if(!errors.isEmpty()) {
        next(errors);
    }
    next();    
}
module.exports = validateBody;