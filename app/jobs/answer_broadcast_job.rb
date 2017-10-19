class AnswerBroadcastJob < ApplicationJob
  queue_as :default

  def perform(answer)
    ActionCable.server.broadcast "game-#{answer.question.game_id}: answers", { message: answer_submitted, message_type: "answer" }
  end

  private
    # def render_message(answer)
      # ApplicationController.renderer.render(partial: 'answers/answer', locals: { answer: answer })
    # end

    def answer_submitted
      "<div class='answer_content'>One answer has been submitted.</div>"
    end
end
