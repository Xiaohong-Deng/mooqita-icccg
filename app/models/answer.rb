class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates :question_id, uniqueness: { scope: :user_id }
  # if an entry to be updated has judge_choice = true, will check if there is already an entry
  # with the same question_id and judge_choice
  validates :question_id, uniqueness: { scope: :judge_choice }, if: Proc.new { |a| a.judge_choice }

  after_create_commit { AnswerBroadcastJob.perform_now self }

  def self.judge_identified_answer_for(question)
    find_by(question_id: question.id, judge_choice: true)
  end

  def make_judge_identified!
    update!(judge_choice: true)
  end
end
