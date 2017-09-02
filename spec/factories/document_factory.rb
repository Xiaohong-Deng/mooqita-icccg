FactoryGirl.define do
  factory :document do
    title { "dummy title" }
    content { "This is a single dummy document meant to be tested by rspec. This document should not be used under any other conditions." }
  end
end
