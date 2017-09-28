$(document).ready ->
  # alert "hello world" workds fine
  submitQuestion()
  submitAnswer()
  return

gameId = window.location.pathname.substring("games/".length + 1)

App['game' + gameId] = App.cable.subscriptions.create {channel: "GameChannel", game: parseInt(gameId, 10)},
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    # console.log "message received"
    if data.message_type is "question"
      # alert "question received"
      $("#current_question").append data.message
      $("#new_answer").removeClass 'hidden'
    else if data.message_type is "answer"
      # console.log "answer received"
      $("#current_answer").append data.message
      if $("#current_answer .current_answer").length is 2
        console.log "requestJudgeForm"
        requestJudgeForm()
    else
      revealNextRound()

  setGameId: (gameId)->
    @gameId = gameId
    return


submitQuestion = ->
  $("#question_content").keydown (event) ->
    # alert "key down" workds fine
    if event.keyCode is 13 && !event.shiftKey
      question = event.target.value
      gameId = $("[data-game]").data().game
      App['game' + gameId].setGameId gameId
      App['game' + gameId].send {question: question}
      $('#question_content').val ""
      $(this).hide()
      return false

submitAnswer = ->
  $("#answer_content").keydown (event)->
    if event.keyCode is 13 && !event.shiftKey
      answer = event.target.value
      gameId = $("[data-game]").data().game
      App['game' + gameId].setGameId gameId
      App['game' + gameId].send {answer: answer}
      $('#answer_content').val ""
      $(this).hide()
      return false

requestJudgeForm = ->
  if $("#judge_form").length isnt 0
    $.get("games/" + gameId + "/judge", {game_id: gameId}, (data)->
      $("#judge_form").append data
    )

revealNextRound = ->
  $('input[value="Next Round"]').removeClass 'hidden'
