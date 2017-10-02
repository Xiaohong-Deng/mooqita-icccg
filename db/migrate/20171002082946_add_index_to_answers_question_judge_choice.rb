class AddIndexToAnswersQuestionJudgeChoice < ActiveRecord::Migration[5.1]
  def change
    add_index :answers, [:question_id, :judge_choice], unique: true, where: "judge_choice is true"
  end
end
