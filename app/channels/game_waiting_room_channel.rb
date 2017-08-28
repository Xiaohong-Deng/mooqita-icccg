class GameWaitingRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
    stream_from 'waiting-room'

    add_current_user
  end

  def unsubscribed
    unless user_has_other_connections?
      GameWaitingRoom.remove(current_user)
      ParticipantsBroadcastJob.perform_now(false)
    end
  end

  private

  def add_current_user
    GameWaitingRoom.add(current_user)
    @game = create_game if GameWaitingRoom.full?

    CurrentUserBroadcastJob.perform_later(current_user, @game)
    ParticipantsBroadcastJob.perform_now(@game)
  end

  def create_game
    Game.create_with_users_ids(GameWaitingRoom.users_ids)
  end

  def user_has_other_connections?
    connection.server.connections.map(&:current_user).include?(current_user)
  end
end
