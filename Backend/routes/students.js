//1. Fetch Students from particular teacher
const express = require('express');
const registeredStudents = require('../controller/registered_students_controller');
const router = express.Router();
const verify = require('../middleware/verify')

router.get('/getStudents/:code' , verify, registeredStudents.registered_students)

module.exports = router;