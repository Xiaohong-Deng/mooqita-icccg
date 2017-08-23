class GameChannel < ApplicationCable::Channel
  def subscribed
    @game = Game.add_or_new(current_user)
    stream_for @game
    stream_from "game_player_#{current_user.id}"
    InitialPlayerBroadcastJob.perform_later(@game, current_user)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    Game.remove(@game, current_user)
    StatusBroadcastJob.perform_now(@game)
  end
end
