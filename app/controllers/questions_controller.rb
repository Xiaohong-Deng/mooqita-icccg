# class QuestionsController < ApplicationController
#   before_action :authenticate_user!
#   before_action :set_game
#   before_action :authenticate_player!

#   def create
#     question = Question.new(question_params)
#     question.user = current_user
#     unless question.save
#       flash.now[:alert] = "Question has not been created."
#       render 'games/show'
#     end
#   end

#   private
#     def set_game
#       @game = Game.find(params[:question][:game_id])
#     end

#     def question_params
#       params.require(:question).permit(:content, :game_id, :round)
#     end
# end
