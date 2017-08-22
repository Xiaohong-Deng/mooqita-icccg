class GameStartingBroadcastJob < ApplicationJob
  queue_as :default

  def perform(game)
    ActionCable.server.broadcast "game_#{game.id}", {data: data(game), status: game.status}
  end

  private

  def data(game)
    GamesController.render(partial: 'games/starting', locals: {game: game})
  end
end
