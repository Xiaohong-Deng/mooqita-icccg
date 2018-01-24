require 'rails_helper'

RSpec.describe AnswerPolicy do
  context 'permissions' do
    subject { AnswerPolicy.new(user, answer) }

    let(:user) { FactoryBot.create(:user) }
    let(:document) { FactoryBot.create(:document) }
    let(:game) { FactoryBot.create(:game, document: document) }
    let(:question) { FactoryBot.create(:question, game: game, user: FactoryBot.create(:user), round: ROUND) }
    let(:answer) { FactoryBot.create(:answer, question: question, user: FactoryBot.create(:user)) }

    context 'for anonymous users' do
      let(:user) { nil }

      it { should_not permit_action :create }
      it { should_not permit_action :update }
    end

    context 'for judge of the game' do
      before { assign_role!(user, :judge, game) }

      it { should_not permit_action :create }

      context 'when answer is not chosen' do
        it { should permit_action :update }
      end

      context 'when answer is chosen' do
        let(:answer) { FactoryBot.create(:answer, question: question,
          user: FactoryBot.create(:user), judge_choice: true) }

        it { should_not permit_action :update }
      end
    end

    context 'for reader of the game' do
      before { assign_role!(user, :reader, game) }

      it { should_not permit_action :update }

      context "when player's answer is not raised" do
        it { should permit_action :create }
      end

      context "when player's answer is raised" do
        let(:answer) { FactoryBot.create(:answer, question: question, user: user) }

        it { should_not permit_action :create }
      end
    end

    context 'for guesser of the game' do
      before { assign_role!(user, :guesser, game) }

      it { should_not permit_action :update }

      context "when player's answer is not raised" do
        it { should permit_action :create }
      end

      context "when player's answer is raised" do
        let(:answer) { FactoryBot.create(:answer, question: question, user: user) }

        it { should_not permit_action :create }
      end
    end

    context 'for judges of other games' do
      before { assign_role!(user, :judge, FactoryBot.create(:game, document: document)) }

      it { should_not permit_action :create }
      it { should_not permit_action :update }
    end

    context 'for readers of other games' do
      before { assign_role!(user, :reader, FactoryBot.create(:game, document: document)) }

      it { should_not permit_action :create }
      it { should_not permit_action :update }
    end

    context 'for guessers of other games' do
      before { assign_role!(user, :guesser, FactoryBot.create(:game, document: document)) }

      it { should_not permit_action :create }
      it { should_not permit_action :update }
    end
  end
end
