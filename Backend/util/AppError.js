const { firestore, FirebaseError } = require("firebase-admin");

class AppError extends Error {
    constructor(message, statusCode) {
        super(message);
        this.statusCode = statusCode;
        this.message = message;

        Error.captureStackTrace(this, this.constructor);
    }
};

module.exports = AppError;
