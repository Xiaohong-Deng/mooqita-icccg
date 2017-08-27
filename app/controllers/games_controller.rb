class GamesController < ApplicationController
  before_action :authenticate_user!
  def waiting_room
  end

  def show
    @game = Game.find(params[:id])
    authenticate_player!
  end

  private

  def authenticate_player!
    unless @game.players.include? current_user
      flash[:danger] = 'You are not part of the game'
      redirect_to root_path
    end
  end
end
