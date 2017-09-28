class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates :question_id, uniqueness: { scope: :user_id }

  after_create_commit { AnswerBroadcastJob.perform_now self }
  # after judge made his choice broadcast to players to tell it's done
  # show 'next round' button
  after_update_commit {}

  def self.judge_identified_answer_for(question)
    find_by(question_id: question.id, judge_choice: true)
  end

  def make_judge_identified!
    Answer.where(question_id: question.id).update_all(judge_choice: false)
    update!(judge_choice: true)
  end
end
