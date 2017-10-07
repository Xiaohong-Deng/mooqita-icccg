class AnswerPolicy < QuestionPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    if game_player = game.game_players.find_by(user: user)
      question = Question.find_by(game: game, round: game_player.round)
      question && !game.has_judge?(user) && question.answers.find_by(user: user).nil?
    else
      false
    end
  end

  def update?
    game.has_judge?(user) && !Answer.judge_identified_answer_for(record.question)
  end
end
