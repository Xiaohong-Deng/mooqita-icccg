# ActionCable
window.startGameCable = ->
  App.game = App.cable.subscriptions.create "GameChannel",
    received: (data) ->
      @renderTemplate(data)
    renderTemplate: (data) ->
      target = $(data['target'])
      target.html(data['template'])
