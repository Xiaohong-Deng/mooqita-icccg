class Game < ApplicationRecord
  has_many :game_players, dependent: :destroy
  has_many :players, through: :game_players, source: :user

  enum status: [:active, :paused]

  def self.create_with_users_ids(ids)
    game = Game.create
    roles_shuffled = GAME_ROLES.map(&:to_s).shuffle


    ids.zip(roles_shuffled).each do |id, role|
      game.game_players.create(user_id: id, role: role)
    end

    game
  end
end
