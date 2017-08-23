class GameStartingBroadcastJob < ApplicationJob
  queue_as :default

  def perform(game)
    GameChannel.broadcast_to(game, data_for(game))
  end

  private

  def data_for(game)
    template = GamesController.render(partial: 'games/starting', locals: {game: game})
    {target: '.main-container', template: template}
  end
end
