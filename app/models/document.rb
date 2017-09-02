class Document < ApplicationRecord
  def self.random_fetch
    Document.all.order("RANDOM()").first
  end
end
