class InitialPlayerBroadcastJob < ApplicationJob
  queue_as :default

  def perform(player)
    GameChannel.broadcast_to player, data_for(player)
  end

  private

  def data_for(player)
    game = player.game
    template = game.waiting? ? 'waiting' : 'starting'
    template = GamesController.render(partial: "games/#{template}", locals: {game: game})
    {target: '.game', template: template}
  end
end
