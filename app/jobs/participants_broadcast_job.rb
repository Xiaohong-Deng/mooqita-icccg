class ParticipantsBroadcastJob < ApplicationJob
  include Templatable
  
  queue_as :default

  def perform(game)
    ActionCable.server.broadcast('waiting-room', data_for(game))
  end

  private

  def data_for game
    game ? game_starting(game) : participants_size
  end
end
