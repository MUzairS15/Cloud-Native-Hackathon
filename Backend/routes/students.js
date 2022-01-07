const express = require('express');
const registeredStudents = require('../controller/registered_students_controller');
const { handleAsyncError } = require('../middleware/error');
const router = express.Router();

// get Students who are currenttly attending the session
router.get('/getStudents/:code' , handleAsyncError (registeredStudents.registered_students));

module.exports = router;