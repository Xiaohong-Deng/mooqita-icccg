class AnswerPolicy < QuestionPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    # if question exists, and game has member user, and user is not judge, and user hasn't submitted an answer
    record.question && record.question.game.has_member?(user) &&
      !record.question.game.has_judge?(user) && !record.question.has_answer_for?(user)
  end

  def update?
    record.question.game.has_judge?(user) && !record.question.has_judge_choice?
  end
end
