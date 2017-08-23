class GamePlayer < ApplicationRecord
  belongs_to :game
  belongs_to :user

  after_create_commit :update_game_status!
  after_destroy

  def self.add(user)
    game = waiting_game(user) || Game.create

    self.create(game: game, user: user)
  end

  def self.remove(player)
    if game.players.one?
      game.destroy
    else
      self.destroy
    end
  end

  def self.waiting_game(user)
    Game.joins(:game_players).
      where("(status = ? AND game_players.user_id = ?) or (status = ?)", 0, user.id, 0).first
  end

  private

  def update_game_status!
    game.active! if game.players.size == GAME_SIZE
  end
end
