class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :game
  belongs_to :user
  validates :game_id, uniqueness: { scope: :round }

  after_create_commit { QuestionBroadcastJob.perform_now self }

  def has_answer_for?(user)
    answers.exists?(user: user)
  end

  def has_judge_choice?
    answers.exists?(judge_choice: true)
  end
end
