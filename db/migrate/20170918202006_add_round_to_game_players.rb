class AddRoundToGamePlayers < ActiveRecord::Migration[5.1]
  def change
    add_column :game_players, :round, :integer, default: 1
  end
end
