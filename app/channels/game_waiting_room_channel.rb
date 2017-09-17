class GameWaitingRoomChannel < ApplicationCable::Channel
  def subscribed
    # eq to stream_from "user: some_hash_token_for_current_user"
    stream_for current_user
    stream_from 'waiting-room'

    add_current_user
  end

  def unsubscribed
    unless user_has_other_connections?
      GameWaitingRoom.remove(current_user)
      # game=false
      ParticipantsBroadcastJob.perform_now(false)
    end
  end

  private

  def add_current_user
    GameWaitingRoom.add(current_user)
    @game = create_game if GameWaitingRoom.full?
    # don't see it's necessary to perform other players jobs first
    # might as well play current_user first
    CurrentUserBroadcastJob.perform_later(current_user, @game)
    ParticipantsBroadcastJob.perform_now(@game)
  end

  def create_game
    Game.create_with_users_ids(GameWaitingRoom.users_ids)
  end

  def user_has_other_connections?
    # connection here is eq to ActionCable. wonder why and where the instance
    # 'connection' is instantiated. delegation maybe?
    connection.server.connections.map(&:current_user).include?(current_user)
  end
end
