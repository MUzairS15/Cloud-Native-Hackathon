const app = require('./index')
const port = 80;
const dotenv = require('dotenv');
dotenv.config();

app.listen(port, function(){
    if(process.env.NODE_ENV == 'development') {
        console.log(`Server Started on port ${port}`);
    }
})