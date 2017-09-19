class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :content
      t.references :game, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :round

      t.timestamps
    end
  end
end
