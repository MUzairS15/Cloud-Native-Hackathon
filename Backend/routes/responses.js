// const { response } = require('express');
const express = require('express');
const router = express.Router();
const verify = require('../middleware/verify');

const responseController = require('../controller/response_controller');
router.get('/getstat/:code', verify, responseController.get_stat)

module.exports = router;