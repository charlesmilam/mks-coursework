//Model
(function () {

  // Private 
  // test data
  var _quizzes = [{
        id: 1,
        question: "How much wood would a woodchuck chuck?",
        responses: ["3", "42","an inordinate amount","You woodchucks get away from my wood pile!"],
        answer: 1
        },
        {
          id: 2,
          question: "What type of boat do you own?",
          responses: ["Class C", "Commercial Fishing", "42", "a towel"],
          answer: 2
        }
      ]

  // Public 
  window.Quiz = {}

  Quiz.forEach = function (callback) {
    for (var i = 0; i < _quizzes.length; i++) {
      callback(extend({}, _quizzes[i]))
    }
  }

  Quiz.checkAnswers = function (responses) {
    console.log("in checkAnswer")
    var correct = 0
    responses.forEach(function (response) {
      _quizzes.forEach(function (answer) {
        console.log("ans id")
        console.log(answer.id)
        console.log("resp id")
        console.log(response.id)
        console.log("ans")
        console.log(answer.answer)
        console.log("resp")
        console.log(response.response)
        if ((answer.id == response.id)  && (answer.answer == response.response)) {
          console.log("in correct")
          correct += 1
        }
      })
    })
    console.log(correct)
    return correct
  }


})()