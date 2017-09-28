class AddIndexToQuestionsGameRound < ActiveRecord::Migration[5.1]
  def change
    add_index :questions, [:game_id, :round], unique: true
  end
end
