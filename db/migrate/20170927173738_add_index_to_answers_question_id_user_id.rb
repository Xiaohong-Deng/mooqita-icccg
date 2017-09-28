class AddIndexToAnswersQuestionIdUserId < ActiveRecord::Migration[5.1]
  def change
    add_index :answers, [:question_id, :user_id], unique: true
  end
end
