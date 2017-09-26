class QuestionBroadcastJob < ApplicationJob
  queue_as :default

  def perform(question)
    ActionCable.server.broadcast "game-#{question.game_id}: questions", { message: render_message(question),
      message_type: "question", round: question.round }
  end

  private
    def render_message(question)
      ApplicationController.renderer.render(partial: 'questions/question', locals: { question: question })
    end
end
