class GameChannel < ApplicationCable::Channel
  def subscribed
    add_user_to_game

    stream_for current_user
    stream_for current_user.game

    InitialPlayerBroadcastJob.perform_later(current_user)
    ParticipantsBroadcastJob.perform_now(current_user.game)
  end

  def unsubscribed
    if !user_has_other_connections? && current_user.game.waiting?
      GamePlayer.remove(current_user)
      ParticipantsBroadcastJob.perform_now(current_user.game)
    end
  end

  private

  def add_user_to_game
    connection.current_user = GamePlayer.add(current_user)
  end

  def user_has_other_connections?
    connection.server.connections.map(&:current_user).include?(current_user)
  end
end
