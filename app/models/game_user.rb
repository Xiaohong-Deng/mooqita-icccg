class GameUser < ApplicationRecord
  belongs_to :game
  belongs_to :user

  after_create_commit do
    update_game_status!

    if game.active?
      GameStartingBroadcastJob.perform_now(game)
    else
      StatusBroadcastJob.perform_now(game)
    end
  end

  after_destroy_commit { StatusBroadcastJob.perform_now(game) }

  private

  def update_game_status!
    if game.number_of_players == 3
      game.active!

    end
  end
end
