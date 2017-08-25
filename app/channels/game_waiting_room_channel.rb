class GameWaitingRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
    stream_from 'waiting-room'

    GameWaitingRoom.add(current_user)
    game = create_game

    CurrentUserBroadcastJob.perform_later(current_user, game)
    ParticipantsBroadcastJob.perform_now(game)
  end

  def unsubscribed
    unless user_has_other_connections?
      GameWaitingRoom.remove(current_user)
      ParticipantsBroadcastJob.perform_now(false)
    end
  end

  private

  def create_game
    Game.create_with_users_ids(GameWaitingRoom.users_ids) if GameWaitingRoom.full?
  end

  def add_user_to_game
    connection.current_user = GamePlayer.add(current_user)
  end

  def user_has_other_connections?
    connection.server.connections.map(&:current_user).include?(current_user)
  end
end
