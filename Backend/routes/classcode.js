//1. Add teacher name and classcode to database

const express = require('express');
const router = express.Router();
const verify = require('../middleware/verify');
const classController = require('../controller/classcode_controller');

// Also add name of person in db who generated code
router.post('/addClass', verify, classController.generate_codes)
//name is teacher name

router.get('/getCodes', verify, classController.get_codes)
module.exports = router;