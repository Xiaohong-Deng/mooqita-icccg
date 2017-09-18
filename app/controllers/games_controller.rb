class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game
  before_action :authenticate_player!
  before_action :set_game_player

  def show
    unless @role == "guesser"
      @document = @game.document
    end
  end

  def update
    round = @game_player.round + 1
    if @game_player.update(round: round)
      flash[:notice] = "You successfully entered the next round"
      redirect_to game_path
    else
      flash[:alert] = "You failed to enter the next round"
      redirect_to root_path
    end
  end

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

    def set_game_player
      @game_player = @game.game_players.find_by(user: current_user)
    end
end
