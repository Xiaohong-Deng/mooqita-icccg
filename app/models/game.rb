class Game < ApplicationRecord
  has_many :game_players, dependent: :destroy
  has_many :players, through: :game_players, source: :user
  has_many :questions, dependent: :nullify
  belongs_to :document

  enum status: [:active, :paused]

  def self.create_with_users_ids(ids)
    game = Game.create(document: Document.random_fetch)
    roles_shuffled = GAME_ROLES.map(&:to_s).shuffle
    game_players = game.game_players

    ids.zip(roles_shuffled).each do |id, role|
      game_players.create(user_id: id, role: role)
    end

    game_players.exclude_role("judge").shuffle[0].set_questioner

    game
  end
end
