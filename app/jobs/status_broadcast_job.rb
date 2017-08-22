class StatusBroadcastJob < ApplicationJob
  queue_as :default

  def perform(game)
    ActionCable.server.broadcast "game_#{game.id}", number_of_players: game.number_of_players, status: game.status
  end
end
