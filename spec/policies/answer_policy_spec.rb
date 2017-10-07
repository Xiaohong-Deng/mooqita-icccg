require 'rails_helper'

RSpec.describe AnswerPolicy do
  context 'permissions' do
    subject { AnswerPolicy.new(GameChannelContext.new(user, game), answer) }

    let(:user) { FactoryGirl.create(:user) }
    let(:document) { FactoryGirl.create(:document) }
    let(:game) { FactoryGirl.create(:game, document: document) }
    let(:question) { FactoryGirl.create(:question, game: game, user: FactoryGirl.create(:user), round: ROUND) }
    let(:answer) { FactoryGirl.create(:answer, question: question, user: FactoryGirl.create(:user)) }

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
        let(:answer) { FactoryGirl.create(:answer, question: question,
          user: FactoryGirl.create(:user), judge_choice: true) }

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
        let(:answer) { FactoryGirl.create(:answer, question: question, user: user) }

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
        let(:answer) { FactoryGirl.create(:answer, question: question, user: user) }

        it { should_not permit_action :create }
      end
    end

    context 'for judges of other games' do
      before { assign_role!(user, :judge, FactoryGirl.create(:game, document: document)) }

      it { should_not permit_action :create }
      it { should_not permit_action :update }
    end

    context 'for readers of other games' do
      before { assign_role!(user, :reader, FactoryGirl.create(:game, document: document)) }

      it { should_not permit_action :create }
      it { should_not permit_action :update }
    end

    context 'for guessers of other games' do
      before { assign_role!(user, :guesser, FactoryGirl.create(:game, document: document)) }

      it { should_not permit_action :create }
      it { should_not permit_action :update }
    end
  end
end
