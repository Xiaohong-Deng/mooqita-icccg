class StagesController < ApplicationController
  before_action :set_game
  before_action :set_role
  before_action :set_stage

  # use partials to render different stage pages for show
  def show
    unless @role == "guesser"
      @document = @game.document
    end

    unless (1..4).include? params[:id].to_i
      flash[:error] = "The page you are looking for doesn't exist."
      redirect_to root_path
    end
  end

  private

    def set_game
      @game = Game.find(params[:game_id])
    end

    def set_role
      @role = @game.game_players.find(current_user.id).role
    end

    def set_stage
      @stage = Stage.find(params[:id])
    end
end
