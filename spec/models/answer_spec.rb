require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:document) { FactoryGirl.create(:document) }
  let(:game) { FactoryGirl.create(:game, document: document) }
  let(:question) { FactoryGirl.create(:question, game: game, user: user1) }

  before do
    @answer1 = Answer.create(content: "I ate yesterday", user: user1, question: question)
    @answer2 = Answer.create(content: "I did't eat yesterday", user: user2, question: question, judge_choice: true)
  end

  it 'can set itself to judge identified' do
    expect(@answer1.judge_choice?).to eq false
    expect(@answer2.judge_choice?).to eq true

    @answer1.make_judge_choice!
    @answer2.reload

    expect(@answer1.judge_choice?).to eq true
    expect(@answer2.judge_choice?).to eq false
  end

  it 'return the judge chosen answer for a particular question' do
    judge_choice = Answer.judge_choice_for question
    expect(judge_choice.content).to eq "I did't eat yesterday"
  end
end
