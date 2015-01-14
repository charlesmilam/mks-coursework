// Presenter
(function () {
  renderQuizzes()
  
  function renderQuizzes () {
    Quiz.forEach(function(quiz) {
      //var quizId = $("<input type='text' name='quizId'>").val(quiz.id)
      var question = $("<h3>").text(quiz.question)
      //$(".quiz-question").append(quizId)
      $(".quiz-question").append(question)
    
    
      //$(".quiz-responses").empty()
      var quizResponses = $(".quiz-responses")
      _.each(quiz.responses, function(response, index) {
        var radio = $("<input>")
        radio.attr({type: 'radio', name: quiz.id})
        radio.prop("value", index)
        var label = $("<label>").text(response)
        $(".quiz-question").append(radio)
        $(".quiz-question").append(label)
        $(".quiz-question").append($("<br>"))
      })  
      //$(".quiz-question").append($("<input type='submit' name='quiz-submit' value='Answer Me' />"))
    })
  }

  $("#quiz-form").on("submit", function(e) {
    e.preventDefault()
    // console.log($('input[name=quiz-response]:checked').val())
    // console.log($("input[name=quizId").val())
    var responses = []
    var quizUser = $("input[name=quiz-user").val()
    console.log(quizUser)
    //$("input[type=text]")
    $("input[type=radio]").each (function(elem) {
      // console.log(this.name)
      // console.log(this.checked)
      if (this.checked) {
        var respsonse = {}
        respsonse["id"] =  this.name
        respsonse["response"] = this.value
        console.log(respsonse)
        responses.push(respsonse)
      }
    })
    console.log(responses)
    
    var stats = Quiz.checkAnswers(quizUser, responses)
    alert("You got " + stats["correct"] + " correct")
    $("#question1-avg").text(stats["avgQ1"])
    $("#hi-score-name").text(stats["highName"])
    $("#hi-score-score").text(stats["highScore"])

  })

  // $("#quiz-form").on("click", "input[type=radio]", function() {
  //   console.log("in radio event")
  //   console.log(this.value)
  // })


}) ()