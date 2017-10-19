require 'rails_helper'

RSpec.describe QuestionPolicy do
  context 'permissions' do
    subject { QuestionPolicy.new(user,
      FactoryGirl.create(:question, game: game, user: FactoryGirl.create(:user))) }

    let(:user) { FactoryGirl.create(:user) }
    let(:document) { FactoryGirl.create(:document) }
    let(:game) { FactoryGirl.create(:game, document: document) }

    context 'for anonymous users' do
      let(:user) { nil }

      it { should_not permit_action :create }
    end

    context 'for judge of the game' do
      before { assign_role!(user, :judge, game) }

      it { should_not permit_action :create }
    end

    context 'for reader of the game' do
      before { assign_role!(user, :reader, game) }

      context 'when is not the questioner' do
        it { should_not permit_action :create }
      end

      context 'when is the questioner' do
        before { assign_role!(user, :reader, game, questioner: true) }

        context 'and question has not been raised' do
          it { should permit_action :create }
        end

        context 'and question has been raised' do
          let!(:question) { FactoryGirl.create(:question, game: game, user: FactoryGirl.create(:user), round: ROUND) }

          it { should_not permit_action :create }
        end
      end
    end

    context 'for guesser of the game' do
      before { assign_role!(user, :guesser, game) }

      context 'when is not the questioner' do
        it { should_not permit_action :create }
      end

      context 'when is the questioner' do
        before { assign_role!(user, :guesser, game, questioner: true) }

        context 'and question has not been raised' do
          it { should permit_action :create }
        end

        context 'and question has been raised' do
          let!(:question) { FactoryGirl.create(:question, game: game, user: FactoryGirl.create(:user), round: ROUND) }

          it { should_not permit_action :create }
        end
      end
    end

    context 'for judges of other games' do
      before { assign_role!(user, :judge, FactoryGirl.create(:game, document: document)) }

      it { should_not permit_action :create }
    end

    context 'for readers of other games' do
      before { assign_role!(user, :reader, FactoryGirl.create(:game, document: document)) }

      it { should_not permit_action :create }
    end

    context 'for guessers of other games' do
      before { assign_role!(user, :guesser, FactoryGirl.create(:game, document: document)) }

      it { should_not permit_action :create }
    end
  end
end
