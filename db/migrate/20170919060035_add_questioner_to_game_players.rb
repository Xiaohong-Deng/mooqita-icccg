class AddQuestionerToGamePlayers < ActiveRecord::Migration[5.1]
  def change
    add_column :game_players, :questioner, :boolean, default: false
  end
end
