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
    if !user_has_other_connections?(current_user) && @player.game.waiting?
      GamePlayer.remove(@player)
      ParticipantsBroadcastJob.perform_now(@player.game)
    end
  end

  private

  def user_has_other_connections?(user)
    connection.server.connections.map(&:current_user).include?(user)
  end
end
