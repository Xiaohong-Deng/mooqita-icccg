class GamePlayer < ApplicationRecord
  belongs_to :game
  belongs_to :user

  enum role: [:unassigned] + GAME_ROLES
end
