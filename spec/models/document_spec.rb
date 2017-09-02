require 'rails_helper'

RSpec.describe Document, type: :model do
  it 'should be able to return a random document' do
    Document.create(title: "dummy title", content: "This is a single dummy document meant to be tested by rspec.
       This document should not be used under any other conditions.")
    expect(Document.random_fetch.title).to eq "dummy title"
    expect(Document.random_fetch.content).to eq "This is a single dummy document meant to be tested by rspec.
       This document should not be used under any other conditions."
  end
end
