// Generated by CoffeeScript 1.12.6
var gameId, requestJudgeForm, revealNextRound, submitAnswer, submitQuestion;

$(document).ready(function() {
  submitQuestion();
  submitAnswer();
});

gameId = window.location.pathname.substring("games/".length + 1);

App['game' + gameId] = App.cable.subscriptions.create({
  channel: "GameChannel",
  game: parseInt(gameId, 10)
}, {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    if (data.message_type === "question") {
      $("#current_question").append(data.message);
      return $("#new_answer").removeClass('hidden');
    } else if (data.message_type === "answer") {
      $("#current_answer").append(data.message);
      if ($("#current_answer .current_answer").length === 2) {
        return requestJudgeForm();
      }
    } else {
      $("#info").append(data.message);
      return revealNextRound();
    }
  },
  setGameId: function(gameId) {
    this.gameId = gameId;
  }
});

submitQuestion = function() {
  return $("#question_content").keydown(function(event) {
    var question;
    if (event.keyCode === 13 && !event.shiftKey) {
      question = event.target.value;
      gameId = $("[data-game]").data().game;
      App['game' + gameId].setGameId(gameId);
      App['game' + gameId].send({
        question: question
      });
      $('#question_content').val("");
      $(this).hide();
      return false;
    }
  });
};

submitAnswer = function() {
  return $("#answer_content").keydown(function(event) {
    var answer;
    if (event.keyCode === 13 && !event.shiftKey) {
      answer = event.target.value;
      gameId = $("[data-game]").data().game;
      App['game' + gameId].setGameId(gameId);
      App['game' + gameId].send({
        answer: answer
      });
      $('#answer_content').val("");
      $(this).hide();
      return false;
    }
  });
};

requestJudgeForm = function() {
  if ($("#judge_form").length !== 0) {
    console.log("sending judge form request");
    return $.get(gameId + "/judge", function(data) {
      return $("#judge_form").append(data);
    });
  }
};

revealNextRound = function() {
  return $('input[value="Next Round"]').removeClass('hidden');
};
