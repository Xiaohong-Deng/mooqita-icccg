class GameUser < ApplicationRecord
  belongs_to :game
  belongs_to :user

  after_save :update_game_status
  
  def update_game_status
    game.active! if game.number_of_players == 3
  end
end
