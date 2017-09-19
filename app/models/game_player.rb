class GamePlayer < ApplicationRecord
  belongs_to :game
  belongs_to :user
  scope :exclude_role, lambda { |role| where.not(role: role) }

  enum role: [:unassigned] + GAME_ROLES

  def set_questioner
    update(questioner: true)
  end
end
