require "rails_helper"
require_relative "shared_examples/reader"
require_relative "shared_examples/whiteboard"
require_relative "shared_examples/game_attributes"

RSpec.describe 'Players can play the game' do
  let(:user) { FactoryGirl.create(:user) }
  let(:document) { FactoryGirl.create(:document) }
  let(:game) { FactoryGirl.create(:game, document: document) }
  let!(:question) { FactoryGirl.create(:question, game: game, user: FactoryGirl.create(:user)) }
  let!(:answer) { FactoryGirl.create(:answer, question: question,
    user: FactoryGirl.create(:user), judge_choice: true) }

  before do
    login_as(user)
  end

  context 'when visit the game page' do

    context 'as a judge' do
      before do
        assign_role!(user, :judge, game)
        @game_player = GamePlayer.find_by(user: user)
        visit game_path(game)
      end

      it_behaves_like 'reader'
      include_examples 'whiteboard'
      include_examples 'game_attributes', :judge, 'not questioner'
    end

    context 'as a reader' do
      before do
        assign_role!(user, :reader, game)
        @game_player = GamePlayer.find_by(user: user)
        visit game_path(game)
      end

      it_behaves_like 'reader'
      include_examples 'whiteboard'
      include_examples 'game_attributes', :reader, 'questioner'
    end

    context 'as a guesser' do
      before do
        assign_role!(user, :guesser, game,)
        @game_player = GamePlayer.find_by(user: user)
        visit game_path(game)
      end

      scenario 'can not see the document content' do
        expect(page).not_to have_selector "#document"
        expect(page).not_to have_content "Document"

        expect(page).not_to have_content "dummy title"
        expect(page).not_to have_content "This is a single dummy document meant to be tested by rspec.
        This document should not be used under any other conditions."
      end

      include_examples 'whiteboard'
      include_examples 'game_attributes', :guesser, 'questioner'
    end
  end

end
