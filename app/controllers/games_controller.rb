class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game
  before_action :authenticate_player!

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def authenticate_player!
    unless @game.players.include? current_user
      flash[:danger] = 'You are not part of the game'
      redirect_to root_path
    end
  end
end
