const dotenv = require('dotenv');
const AppError = require('../util/AppError');
dotenv.config();

const sendDevError = function (err, res) {
    if(Array.isArray(err.errors)) {
        res.json({
            error: err.errors,
            message: "Input validation Failed"
        })
    } else {
        res.json({
            status: err.statusCode,
            msg: err.message,
            stack: err.stack
        })
    }
}

const sendProdError = function (err, res) {
    if(Array.isArray(err.errors)) {
        res.json({
            error: err.errors,
            message: "Please enter correct"
        })
    } else {
        res.json({
            status: err.statusCode,
            err: err.message
        })
    }
}

const errorHandler = function(err, req, res, next) {
    if(process.env.NODE_ENV === "development") {
        sendDevError(err,res);
    } else{
        sendProdError(err,res);
    }
}

const handleAsyncError = function(fun) {
    return function(req, res, next){
        fun(req, res, next).catch(err=>{
            next(err)
        });
    }
}

module.exports = {errorHandler, handleAsyncError};
