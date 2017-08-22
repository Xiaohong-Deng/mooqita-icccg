class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_#{params[:id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    player = GameUser.find_by(user: current_user)
    Game.remove(player)
  end

  def status
    ActionCable.server.broadcast 'game_channel', data: 'hello'
  end
end
