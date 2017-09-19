require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:document) { FactoryGirl.create(:document) }
  let(:game) { FactoryGirl.create(:game, document: document) }
  let(:question) { FactoryGirl.create(:question, game: game, user: user) }

  before do
    @answer1 = Answer.create(content: "I ate yesterday", user: user, question: question)
    @answer2 = Answer.create(content: "I did't eat yesterday", user: user, question: question, judge_choice: true)
  end

  it 'can set itself to judge identified' do
    expect(@answer1.judge_choice?).to eq false
    expect(@answer2.judge_choice?).to eq true

    @answer1.make_judge_identified!
    @answer2.reload

    expect(@answer1.judge_choice?).to eq true
    expect(@answer2.judge_choice?).to eq false
  end

  it 'return the judge chosen answer for a particular question' do
    judge_choice = Answer.judge_identified_answer_for question
    expect(judge_choice.content).to eq "I did't eat yesterday"
  end
end
