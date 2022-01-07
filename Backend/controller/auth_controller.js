const db = require('../database');
const AppError = require('../util/AppError');
const jwt = require('jsonwebtoken');

const registeredUsers = db.collection('registered-users');
const privateKey = "mynameisuzair";

exports.SignUp = async function(req, res, next){
  
    const {username, password, name} = req.body;

    // Check if user with provided username already exists
    const userEmail = await registeredUsers.where('username','==',username).get();
    if(userEmail.empty){
        const newUser = await registeredUsers.add({
            id: "",
            name: name,
            username: username,
            password: password
        })
        await newUser.update({id: newUser.id});
        const id = newUser.id;
        const auth_token = jwt.sign({id: id}, privateKey);

        res.status(200).json({auth_token}); //send auth-token when credentials are correct
    }else{
       next(new AppError("A user with this e-mail already exists.",403));
    }
}

exports.LogIn = async function(req, res, next){

    const userEmail = await registeredUsers.where('username','==',req.body.username).limit(1).get();
    if(userEmail.size === 0) {
        next(new AppError("Please register yourself", 403))
    }
    userEmail.forEach((doc) =>{
        if(!doc.exists){
                next(new AppError("Enter valid credentials", 401));
            }    
            else if(doc.data().password != req.body.password){
                next(new AppError("Enter valid credentials", 401));
            }else{
                const auth_token = jwt.sign({id: doc.data().id}, privateKey);
                res.json({"success":true,auth_token})
            }
    })
}