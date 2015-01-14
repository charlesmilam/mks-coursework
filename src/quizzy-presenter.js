// Presenter
(function () {
  renderQuizzes()
  
  function renderQuizzes () {
    Quiz.forEach(function(quiz) {
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

  $("#quiz-form").on("click", "input[type=button", function(e) {
    e.preventDefault()


  })


}) ()