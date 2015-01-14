// Presenter
(function () {
  // test data
  quizzes = [{
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

  console.log (quizzes)
  
  renderQuizzes()
  
  function renderQuizzes () {
    _.each(quizzes, function(quiz) {
      var question = $("<h3>").text(quiz.question)
      $(".quiz-question").append(question)
    
    
      //$(".quiz-responses").empty()
      var quizResponses = $(".quiz-responses")
      _.each(quiz.responses, function(response) {
        var radio = $("<input type='radio'>")
        var span = $("<span>").text(response)
        $(".quiz-question").append(radio)
        $(".quiz-question").append(span)
        $(".quiz-question").append($("<br>"))
      })  
      $(".quiz-question").append($("<button type='submit'>Answer Me</button>"))
    })
  }


}) ()