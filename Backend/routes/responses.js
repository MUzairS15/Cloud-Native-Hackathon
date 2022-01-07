const express = require('express');
const router = express.Router();
const responseController = require('../controller/response_controller');
const { handleAsyncError } = require('../middleware/error');

// get responses for the Quiz conducted and statistics for performance of whole class 
router.get('/getstat/:code', handleAsyncError (responseController.get_stat));

module.exports = router;