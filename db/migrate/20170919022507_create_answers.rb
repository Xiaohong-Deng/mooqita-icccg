class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.text :content
      t.references :question, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :judge_choice, default: false

      t.timestamps
    end
  end
end
