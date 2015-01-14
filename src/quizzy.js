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

  var _highScore = 0
  var _highScoreName 
  var _q1Avg = []
  var _q2Avg = []

  // Public 
  window.Quiz = {}

  Quiz.forEach = function (callback) {
    for (var i = 0; i < _quizzes.length; i++) {
      callback(extend({}, _quizzes[i]))
    }
  }

  Quiz.checkAnswers = function (quizUser, responses) {
    console.log("in checkAnswer")
    console.log("quiz user")
    console.log(quizUser)
    var correct = 0
    responses.forEach(function (response) {
      _quizzes.forEach(function (answer) {
        
        // console.log("ans id")
        // console.log(answer.id)
        // console.log("resp id")
        // console.log(response.id)
        // console.log("ans")
        // console.log(answer.answer)
        // console.log("resp")
        // console.log(response.response)
        if ((answer.id == response.id)  && (answer.answer == response.response)) {
          console.log("in correct")
          correct += 1
          if (response.id === 1) {
            _q1Avg = correct
          }
          else {
            _q2Avg = correct
          }
        }
      })
    })
    console.log(correct)
    if (_q1Avg.length) {
      var sumQ1 = _q1Avg.reduce(function(a, b) { return a + b });
      var avgQ1 = sumQ1 / _q1Avg.length;
      console.log("q1 avg")
      console.log(avgQ1)
    }
    
    if (correct > _highScore) {
      _highScore = correct
      _highScoreName = quizUser
      console.log(_highScore)
      console.log(_highScoreName)
    };
    stats = {
      correct: correct,
      highScore: _highScore,
      highName: _highScoreName,
      avgQ1: avgQ1
    }
    console.log(stats)
    return stats
  }


})()