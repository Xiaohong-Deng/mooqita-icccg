class CurrentUserBroadcastJob < ApplicationJob
  queue_as :default

  def perform(user, game)
    GameWaitingRoomChannel.broadcast_to user, data_for(game)
  end

  private

  def data_for(game)
    template = GamesController.render(template(game))
    {target: '.game', template: template}
  end

  def template(game)
    if game
      {partial: "games/starting", locals: {game_id: game.id}}
    else
      {
        partial: "games/waiting",
        locals: {participants_size: GameWaitingRoom.participants_size}
      }
    end
  end
end
