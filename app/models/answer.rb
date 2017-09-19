class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  def self.judge_identified_answer_for(question)
    find_by(question_id: question.id, judge_choice: true)
  end

  def make_judge_identified!
    Answer.where(question_id: question.id).update_all(judge_choice: false)
    update!(judge_choice: true)
  end
end
