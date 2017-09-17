class StagesController < ApplicationController
  before_action :set_game

  def show
  end

  private

    def set_game
      @game = Game.find(params[:game_id])
    end
end
