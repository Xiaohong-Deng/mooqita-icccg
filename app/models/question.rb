class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :game
  belongs_to :user

  after_create_commit { QuestionBroadcastJob.perform_now self }
end
