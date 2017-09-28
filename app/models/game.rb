class Game < ApplicationRecord
  has_many :game_players, dependent: :destroy
  has_many :players, through: :game_players, source: :user
  has_many :questions, dependent: :nullify
  belongs_to :document

  enum status: [:active, :paused]

  def self.create_with_users_ids(ids)
    # if validation fails Game.find(game.id) wont find anything
    # but create returns an invalid game object
    document = Document.random_fetch
    unless document
      # return nil indicating game creating failure
      return document
    end
    game = Game.create(document: document)
    roles_shuffled = GAME_ROLES.map(&:to_s).shuffle
    game_players = game.game_players

    ids.zip(roles_shuffled).each do |id, role|
      game_players.create(user_id: id, role: role)
    end

    game_players.exclude_role("judge").shuffle[0].set_questioner

    game
  end

  def has_member?(user)
    game_players.exists?(user_id: user)
  end

  def has_questioner?(user)
    game_players.exists?(user_id: user, questioner: true)
  end

  GAME_ROLES.each do |role|
    define_method "has_#{role}?" do |user|
      game_players.exists?(user_id: user, role: role)
    end
  end
end
