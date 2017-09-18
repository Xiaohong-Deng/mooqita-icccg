class AddScoreToGamePlayers < ActiveRecord::Migration[5.1]
  def change
    add_column :game_players, :score, :integer, default: 0
  end
end
