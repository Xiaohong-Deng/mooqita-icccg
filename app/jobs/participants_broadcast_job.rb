class ParticipantsBroadcastJob < ApplicationJob
  queue_as :default

  def perform(game)
    ActionCable.server.broadcast('waiting-room', data_for(game))
  end

  private

  def data_for game
    if game
      template = GamesController.render(partial: 'games/starting', locals: {game_id: game.id})
      {target: '.game', template: template}
    else
      {target: '.status span', template: GameWaitingRoom.participants_size}
    end
  end
end
