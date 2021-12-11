
const express = require('express');
const router = express.Router();
const quizController = require('../controller/quiz_controller');
const verify = require('../middleware/verify');


//add question to database
router.post('/live/addQuestion',verify, quizController.add_live_question)

router.post('/addQuestion', verify, quizController.add_question)

router.get('/getQuestion/:code', verify, quizController.get_question_from_bank);

module.exports = router;
