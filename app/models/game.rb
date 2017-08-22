class Game < ApplicationRecord
  has_many :game_players, dependent: :destroy, class_name: 'GameUser'
  has_many :players, through: :game_players, source: :user

  enum status: [:waiting, :active, :paused, :inactive]

  def number_of_players
    players.count
  end

  def self.remove(player)
    game = player.game

    if game.number_of_players == 1
      game.destroy
    else
      player.destroy
    end
  end

  def self.add_or_new(user)
    game = waiting_game(user) || Game.new

    game.game_players.new(user_id: user.id)
    game
  end

  def self.waiting_game(user)
    joins(:game_players).
      where(status: 'waiting').
      where.not(game_users: {user_id: user.id}).first
  end
end
