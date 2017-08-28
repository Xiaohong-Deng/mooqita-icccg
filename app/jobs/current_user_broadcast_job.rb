class CurrentUserBroadcastJob < ApplicationJob
  include Templatable
  
  queue_as :default

  def perform(user, game)
    GameWaitingRoomChannel.broadcast_to user, data_for(game)
  end

  private

  def data_for(game)
    game ? game_starting(game) : game_waiting
  end
end
