class GamePlayer < ApplicationRecord
  belongs_to :game
  belongs_to :user

  after_create_commit :update_game_status!
  after_destroy

  def self.add(user)
    player = find_by(user: user)
    return player if player

    game = Game.waiting.first || Game.create
    self.create(game: game, user: user)
  end

  def self.remove(player)
    if player.game.players.one?
      player.game.destroy
    else
      player.destroy
    end
  end

  private

  def update_game_status!
    game.active! if game.players.size == GAME_SIZE
  end
end
