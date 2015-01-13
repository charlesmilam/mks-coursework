// Presenter
(function () {
  // test data
  quizzes = {
    id: 1,
    question: "How much wood would a woodchuck chuck?",
    responses: ["3", "42","an inordinate amount","You woodchucks get away from my wood pile!"],
    answer: 1
  }

  console.log (quizzes)
  
  renderQuizs()
  
  function renderQuizs () {
    var question = $("<h3>").text(quizzes.question)
    $(".quiz-question").append(question)
    
    
    //$(".quiz-responses").empty()
    var responsesList = $(".responses-list")
      _.each(quizzes.responses, function(response) {
        var radio = $("<input type='radio'>").text(response)
        var li = $("<li>").append(radio)
        console.log(radio)
        //console.log(response)
        $(".responses-list").append(li)
        responsesList.append(li)
      })
        
    
    
    //console.log(responsesList)
    $(".quiz-responses").append(responsesList)
  }


}) ()