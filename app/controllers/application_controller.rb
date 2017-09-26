class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
    def authenticate_player!
      unless @game.players.include? current_user
        flash[:danger] = 'You are not part of the game'
        redirect_to root_path
      end
    end
end
