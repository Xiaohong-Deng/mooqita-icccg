class AddRoleToGamePlayers < ActiveRecord::Migration[5.1]
  def change
    add_column :game_players, :role, :integer, default: 0
  end
end
