const express = require('express');

const router = express.Router();

const validator = require('../middleware/validator');
const { SignUp, LogIn } = require('../controller/auth_controller');
const { handleAsyncError } = require('../middleware/error');

router.use('/createUser',validator);
router.post('/createUser', handleAsyncError (SignUp));

router.post('/login', handleAsyncError (LogIn));
module.exports = router;