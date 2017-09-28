# class AnswersController < ApplicationController
#   before_action :authenticate_user!
#   before_action :set_game
#   before_action :authenticate_player!

#   def create
#     answer = Answer.new(answer_params)
#     answer.user = current_user
#     unless answer.save
#       flash.now[:alert] = "Answer has not been created."
#       render 'games/show'
#     end
#   end

#   private
#     def set_game
#       question = Question.find(params[:answer][:question_id])
#       @game = question.game
#     end

#     def answer_params
#       params.require(:answer).permit(:content, :question_id)
#     end

# end
