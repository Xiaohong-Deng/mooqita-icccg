class GamesController < ApplicationController
  before_action :authenticate_user!

  def create
    game = Game.add_or_new(current_user)

    if game.save
      redirect_to game
      # ActionCable.server.broadcast "game_#{game_id}"
    else
      flash[:danger] = 'something went wrong...'
      redirect_to root_path
    end
  end

  def show
    @game = current_player&.game
    return redirect_to root_path unless @game
    render 'show'
  end

  private

  def current_player
    GameUser.find_by(user: current_user)
  end
end
