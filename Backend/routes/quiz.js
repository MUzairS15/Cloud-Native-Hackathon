
const express = require('express');
const router = express.Router();
const quizController = require('../controller/quiz_controller');
const { handleAsyncError } = require('../middleware/error');


//add question to database for LiveQuiz
router.post('/live/addQuestion', handleAsyncError (quizController.add_live_question));

//add question to database (Question Bank) 
router.post('/addQuestion', handleAsyncError (quizController.add_question));

//get questions from database (Question Bank) 
router.get('/getQuestion/:code', handleAsyncError (quizController.get_question_from_bank));

module.exports = router;
