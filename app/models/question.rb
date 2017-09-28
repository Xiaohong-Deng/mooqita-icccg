class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :game
  belongs_to :user
  validates :game_id, uniqueness: { scope: :round }

  after_create_commit { QuestionBroadcastJob.perform_now self }
end
