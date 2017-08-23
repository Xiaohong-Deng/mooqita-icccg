class InitialPlayerBroadcastJob < ApplicationJob
  queue_as :default

  def perform(game, user)
    channel = "game_player_#{user.id}"
    ActionCable.server.broadcast channel, data_for(game)
  end

  private

  def data_for(game)
    template = game.waiting? ? 'waiting' : 'starting'
    template = GamesController.render(partial: "games/#{template}", locals: {game: game})
    {target: '.main-container', template: template}
  end
end
