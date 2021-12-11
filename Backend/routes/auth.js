const express = require('express');

const router = express.Router();
const db = require('../database');
const jwt = require('jsonwebtoken');

const privateKey = "mynameisuzair";

const registeredUsers = db.collection('registered-users');
router.post('/createUser',async function(req, res){
  
    //try-catch
    const {username, password, name} = req.body;

    const userEmail = await registeredUsers.where('username','==',username).get();
    if(userEmail.empty){
        
        const newUser = await registeredUsers.add({
            id: "",
            name: name,
            username: username,
            password: password
        })
        await newUser.update({id: newUser.id});
        console.log(newUser.id);
        const id = newUser.id;
        const auth_token = jwt.sign({id: id}, privateKey);

        res.status(200).json({auth_token}); //send auth-token
    }else{
       res.json({error:"A user with this e-mail already exists."});
    }

})

router.post('/login', async function(req, res){
    
    const userEmail = await registeredUsers.where('username','==',req.body.username).limit(1).get();
    if(userEmail.size < 1){
        res.json({error:"Enter valid credentials"});
    }
        userEmail.forEach(function(doc){
            console.log(doc.data())
            if(!doc.exists){
                console.log("yes")
                res.json({error:"Enter valid credentials"});
            }    
            else if(doc.data().password != req.body.password){
                res.json({error:"Enter valid credentials"});
            }else{
                const auth_token = jwt.sign({id: doc.data().id}, privateKey);
                res.json({"success":true,auth_token})
            }
    })
})
module.exports = router;