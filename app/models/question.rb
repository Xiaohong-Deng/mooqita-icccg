class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :game
  belongs_to :user
end
