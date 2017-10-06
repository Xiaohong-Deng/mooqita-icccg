RSpec.shared_examples "round_end" do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:question) { FactoryGirl.create(:question, game: game, user: user1, round: ROUND) }
  let!(:answer1) { FactoryGirl.create(:answer, question: question, user: user1) }
  let!(:answer2) { FactoryGirl.create(:answer, question: question, user: user2, judge_choice: true) }
end
