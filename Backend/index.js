
const express = require('express');
const db = require('./database');
const port = 80;
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/api/quiz', require('./routes/quiz'));
app.use('/api/classcode', require('./routes/classcode'));
app.use('/api/students', require('./routes/students'));
app.use('/api/responses', require('./routes/responses'));
app.use('/mobile-user/quiz', require('./routes/quiz'));
app.use('/', require('./routes/auth'));


const connectTodb = async function(){

    console.log("Connected to Firebase...")
}
app.listen(port, function(){
    console.log(`Server Started on port ${port}`);
    connectTodb();
})