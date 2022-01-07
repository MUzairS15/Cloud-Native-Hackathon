
const express = require('express');
const router = express.Router();
const classController = require('../controller/classcode_controller');
const {handleAsyncError} = require('../middleware/error');

router.post('/addClass', handleAsyncError(classController.generate_codes));
router.get('/getCodes', handleAsyncError(classController.get_codes));

module.exports = router;