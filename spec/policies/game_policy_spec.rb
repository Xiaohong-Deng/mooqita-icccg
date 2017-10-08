require 'rails_helper'
require_relative "shared_examples/round_end"

RSpec.describe GamePolicy do
  context 'permissions' do
    subject { GamePolicy.new(user, game) }

    let(:user) { FactoryGirl.create(:user) }
    let(:document) { FactoryGirl.create(:document) }
    let(:game) { FactoryGirl.create(:game, document: document) }

    context 'for anonymous users' do
      let(:user) { nil }

      it { should_not permit_action :show }
      it { should_not permit_action :update }
      it { should_not permit_action :show_questioner }
      it { should_not permit_action :raise_answer }
      it { should_not permit_action :raise_question }
      it { should_not permit_action :judge }
    end

    context 'for judge of the game' do
      before { assign_role!(user, :judge, game) }

      it { should permit_action :show }
      it { should_not permit_action :show_questioner }
      it { should permit_action :judge }
      it { should_not permit_action :raise_question }
      it { should_not permit_action :raise_answer }

      context 'when round has not ended' do
        it { should_not permit_action :update }
      end

      context 'when round has ended' do
        include_examples "round_end"

        it { should permit_action :update }
      end
    end

    context 'for reader of the game' do
      before { assign_role!(user, :reader, game) }

      it { should permit_action :show }
      it { should permit_action :show_questioner }
      it { should permit_action :raise_answer }
      it { should_not permit_action :judge }

      context 'when is not questioner' do
        it { should_not permit_action :raise_question }
      end

      context 'when is questioner' do
        before { assign_role!(user, :reader, game, questioner: true) }

        it { should permit_action :raise_question }
      end

      context 'when round has not ended' do
        it { should_not permit_action :update }
      end

      context 'when round has ended' do
        include_examples "round_end"

        it { should permit_action :update }
      end
    end

    context 'for guesser of the game' do
      before { assign_role!(user, :guesser, game) }

      it { should permit_action :show }
      it { should permit_action :show_questioner }
      it { should permit_action :raise_answer }
      it { should_not permit_action :judge }

      context 'when is not questioner' do
        it { should_not permit_action :raise_question }
      end

      context 'when is questioner' do
        before { assign_role!(user, :guesser, game, questioner: true) }

        it { should permit_action :raise_question }
      end

      context 'when round has not ended' do
        it { should_not permit_action :update }
      end

      context 'when round has ended' do
        include_examples "round_end"

        it { should permit_action :update }
      end
    end

    context 'for judges of other games' do
      before { assign_role!(user, :judge, FactoryGirl.create(:game, document: document)) }

      it { should_not permit_action :show }
      it { should_not permit_action :update }
      it { should_not permit_action :show_questioner }
      it { should_not permit_action :raise_answer }
      it { should_not permit_action :raise_question }
      it { should_not permit_action :judge }
    end

    context 'for readers of other games' do
      before { assign_role!(user, :reader, FactoryGirl.create(:game, document: document)) }

      it { should_not permit_action :show }
      it { should_not permit_action :update }
      it { should_not permit_action :show_questioner }
      it { should_not permit_action :raise_answer }
      it { should_not permit_action :raise_question }
      it { should_not permit_action :judge }
    end

    context 'for guessers of other games' do
      before { assign_role!(user, :guesser, FactoryGirl.create(:game, document: document)) }

      it { should_not permit_action :show }
      it { should_not permit_action :update }
      it { should_not permit_action :show_questioner }
      it { should_not permit_action :raise_answer }
      it { should_not permit_action :raise_question }
      it { should_not permit_action :judge }
    end
  end
end
