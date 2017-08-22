(function() {
  var id = $("#game").attr("game-id");

  App.room = App.cable.subscriptions.create({
    channel: "GameChannel",
    id: id
  }, {
    received: function(data) {
      if (data['status'] === 'active') {
        $('#game').html(data['data']);
      } else {
        return $('.status').html(data['number_of_players']);
      }
    }
  });

  }).call(this);
