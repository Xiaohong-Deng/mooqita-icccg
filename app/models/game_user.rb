class GameUser < ApplicationRecord
  belongs_to :game
  belongs_to :user

  after_create_commit do
    update_game_status!

    case
    when game.active?
      GameStartingBroadcastJob.perform_now(game)
    when game.waiting?
      StatusBroadcastJob.perform_now(game)
    end
  end

  private

  def update_game_status!
    game.active! if game.number_of_players == GAME_SIZE
  end
end
