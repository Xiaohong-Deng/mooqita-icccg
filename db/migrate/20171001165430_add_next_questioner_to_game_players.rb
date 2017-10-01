class AddNextQuestionerToGamePlayers < ActiveRecord::Migration[5.1]
  def change
    add_column :game_players, :next_questioner, :boolean, default: false
  end
end
