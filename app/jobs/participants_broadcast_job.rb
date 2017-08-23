class ParticipantsBroadcastJob < ApplicationJob
  queue_as :default

  def perform(game)
    GameChannel.broadcast_to(game, data_for(game))
  end

  private

  def data_for game
    if game.waiting?
      {target: '.status span', template: game.players.size}
    else
      template = GamesController.render(partial: 'games/starting', locals: {game: game})
      {target: '.game', template: template}
    end
  end
end
