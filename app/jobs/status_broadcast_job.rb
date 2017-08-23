class StatusBroadcastJob < ApplicationJob
  queue_as :default

  def perform(game)
    GameChannel.broadcast_to(game, data_for(game))
  end

  private

  def data_for game
    {target: '.status span', template: game.number_of_players}
  end
end
