class AnswerPolicy < QuestionPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    # if question exists, and game has member user, and user is not judge, and user hasn't submitted an answer
    record.question && record.question.game.has_member?(user) &&
      !record.question.game.has_judge?(user) && record.question.answers.find_by(user: user).nil?
  end

  def update?
    record.question.game.has_judge?(user) && !Answer.judge_choice_for(record.question)
  end
end
