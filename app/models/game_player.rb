class GamePlayer < ApplicationRecord
  belongs_to :game
  belongs_to :user
  scope :exclude_role, lambda { |role| where.not(role: role) }

  enum role: [:unassigned] + GAME_ROLES

  def set_questioner
    update!(questioner: true)
  end

  def set_next_questioner
    update!(next_questioner: true)
  end

  def reset_next_questioner
    update!(next_questioner: false)
  end

  def scored?
    chosen_player = Answer.judge_identified_answer_for(game.questions.find_by(round: round)).user
    # left handles reader and guesser, right handles judge
    # we can not trace back to chosen answer's author's role
    # by question, answer or user_id, so that is convoluted
    ((chosen_player == user) ^ (role == "guesser")) ||
      chosen_player.game_players.find_by(game: game).role == "reader"
  end
end
