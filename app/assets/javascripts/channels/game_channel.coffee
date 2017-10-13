$(document).ready ->
  submitQuestion()
  submitAnswer()
  hideJudgeForm()
  return

gameId = window.location.pathname.substring("games/".length + 1)

App['game' + gameId] = App.cable.subscriptions.create {channel: "GameChannel", game: parseInt(gameId, 10)},
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    if data.message_type is "question"
      $('#current_question').html data.message
      $("#new_answer").removeClass 'hidden'
    else if data.message_type is "answer"
      $('#current_answers').append data.message
      if $("#current_answers .answer_content").length is 2
        requestJudgeForm()
    else
      $("#info").html data.message
      revealNextRound()

  setGameId: (gameId)->
    @gameId = gameId
    return

# we use a form to let users input data but doesn't submit through the form
# it's pretty hacky. bc form need a route, especially we don't need questions_controller
# yet, so the route question#create is there for a dummy form
submitQuestion = ->
  $("#question_content").unbind('keydown').bind 'keydown', (event) ->
    if event.keyCode is 13 && !event.shiftKey
      question = event.target.value
      gameId = $("[data-game]").data().game
      App['game' + gameId].setGameId gameId
      App['game' + gameId].send {question: question}
      $('#question_content').val ""
      $(this).hide()
      return false

submitAnswer = ->
  $("#answer_content").unbind('keydown').bind 'keydown', (event)->
    if event.keyCode is 13 && !event.shiftKey
      answer = event.target.value
      gameId = $("[data-game]").data().game
      App['game' + gameId].setGameId gameId
      App['game' + gameId].send {answer: answer}
      $('#answer_content').val ""
      $(this).hide()
      return

requestJudgeForm = ->
  if $("#judge_form").length isnt 0
    $.get(gameId + "/judge", (data)->
      $("#judge_form").append data
    )

hideJudgeForm = ->
  $(document).on('click', '#0_submit_button', ->
    $('#judge_form').hide()
    return
  )
  $(document).on('click', '#1_submit_button', ->
    $('#judge_form').hide()
    return
  )

revealNextRound = ->
  $('input[value="Next Round"]').removeClass 'hidden'
