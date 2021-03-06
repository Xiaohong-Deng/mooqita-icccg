class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer

  # this method is called from a remote ajax call, it will not cause
  # the client page to reload, so error redirecting will not happen
  # if fails, it fails silently
  def update
    authorize @answer
    if @answer.make_judge_choice!
      @answer.question.game.set_next_questioner
      ActionCable.server.broadcast "game-#{@answer.question.game_id}: info", { message: "Judge made his choice", message_type: "info" }
      head :ok
    else
      # send from a remote call, so no redirect_to actually
      flash[:alert] = "Judge choice has not been updated."
      redirect_to root_path
    end
  end

  private
    def set_answer
      @answer = Answer.find(params[:id])
    end
end
