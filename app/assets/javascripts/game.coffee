$(document).on 'turbolinks:load', () =>
  $('#start-game').on 'click', (e) =>
    spinner = new Spinner().spin()

    $('.main-container').html(spinner.el);
    e.preventDefault;

  # ActionCable

    App.game = App.cable.subscriptions.create "GameChannel",
      received: (data) ->
        @renderTemplate(data)
      renderTemplate: (data) ->
        target = $(data['target'])
        target.html(data['template'])
