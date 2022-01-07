
const express = require('express');
const appError = require('./util/AppError')
const {errorHandler} = require('./middleware/error');
const verifyUser = require('./middleware/verify');
const auth = require('./routes/auth');
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/auth',auth);
app.use(verifyUser);

app.use('/api/quiz', require('./routes/quiz'));
app.use('/api/classcode', require('./routes/classcode'));
app.use('/api/students', require('./routes/students'));
app.use('/api/responses', require('./routes/responses'));
app.use('/mobile-user/quiz', require('./routes/quiz'));
app.all('*', (req, res, next) => {
    next(new appError("Not found"));
});
app.use(errorHandler);

module.exports = app;
