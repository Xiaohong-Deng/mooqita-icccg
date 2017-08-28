class Game < ApplicationRecord
  has_many :game_players, dependent: :destroy
  has_many :players, through: :game_players, source: :user

  enum status: [:active, :paused]

  def self.create_with_users_ids(ids)
    game = Game.create

    ids.each do |id|
      game.game_players.create(user_id: id)
    end

    game
  end
end
