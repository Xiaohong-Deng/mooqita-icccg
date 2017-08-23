class Game < ApplicationRecord
  has_many :game_players, dependent: :destroy
  has_many :players, through: :game_players, source: :user

  enum status: [:waiting, :active, :paused]
end
