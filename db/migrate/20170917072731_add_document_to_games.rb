class AddDocumentToGames < ActiveRecord::Migration[5.1]
  def change
    add_reference :games, :document, foreign_key: true
  end
end
