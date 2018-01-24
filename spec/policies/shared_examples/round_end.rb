RSpec.shared_examples "round_end" do
  let!(:user1) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user) }
  let!(:question) { FactoryBot.create(:question, game: game, user: user1, round: ROUND) }
  let!(:answer1) { FactoryBot.create(:answer, question: question, user: user1) }
  let!(:answer2) { FactoryBot.create(:answer, question: question, user: user2, judge_choice: true) }
end
