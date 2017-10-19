class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    record.game.has_questioner?(user) &&
      Question.find_by(game: record.game, round: record.game.game_players.find_by(user: user).round).nil?
  end
end
