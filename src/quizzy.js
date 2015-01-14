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


})()