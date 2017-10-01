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
end
