class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    record.game.has_questioner?(user) &&
      !record.game.has_question_for?(record.game.game_players.find_by(user: user).round)
  end
end
