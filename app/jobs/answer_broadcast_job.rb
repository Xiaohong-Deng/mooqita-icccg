class AnswerBroadcastJob < ApplicationJob
  queue_as :default

  def perform(answer)
    ActionCable.server.broadcast "game-#{answer.question.game_id}: answers", { message: render_message(answer), message_type: "answer" }
  end

  private
    def render_message(answer)
      ApplicationController.renderer.render(partial: 'answers/answer', locals: { answer: answer })
    end
end
