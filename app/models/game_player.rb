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
    chosen_player = Answer.judge_choice_for(game.questions.find_by(round: round)).user
    # if user is either reader or guesser, then he needs to be chosen to win
    # if user is judge, he can't be chosen, he needs to choose reader to win
    # if reader or guesser is not chosen, then they lose
    chosen_player == user ||
      (user.game_players.find_by(game: game).role == "judge" &&
        chosen_player.game_players.find_by(game: game).role == "reader")
  end
end
