class Document < ApplicationRecord
  has_many :games, dependent: :destroy

  def self.random_fetch
    Document.all.order("RANDOM()").first
  end
end
