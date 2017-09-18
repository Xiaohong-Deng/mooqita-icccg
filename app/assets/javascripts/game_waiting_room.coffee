window.startGameWaitingRoomCable = ->
  App.game = App.cable.subscriptions.create "GameWaitingRoomChannel",
    received: (data) ->
      @renderTemplate(data)
    renderTemplate: (data) ->
      target = $(data['target'])
      # $().html() replace the content of the tag
      # with the content in html()
      target.html(data['template'])
