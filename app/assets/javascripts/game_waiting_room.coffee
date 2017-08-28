window.startGameWaitingRoomCable = ->
  App.game = App.cable.subscriptions.create "GameWaitingRoomChannel",
    received: (data) ->
      @renderTemplate(data)
    renderTemplate: (data) ->
      target = $(data['target'])
      target.html(data['template'])
