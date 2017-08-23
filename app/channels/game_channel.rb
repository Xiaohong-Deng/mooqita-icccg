class GameChannel < ApplicationCable::Channel
  def subscribed
    @player = GamePlayer.add(current_user)
    stream_for @player
    stream_for @player.game

    InitialPlayerBroadcastJob.perform_later(@player)
    ParticipantsBroadcastJob.perform_now(@player.game)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    GamePlayer.remove(@player)
    ParticipantsBroadcastJob.perform_now(@player.game)
  end
end
