require "rails_helper"
ROUND = 42
SCORE = 1024

RSpec.describe 'Players can play the game' do
  let(:user) { FactoryGirl.create(:user) }
  let(:document) { FactoryGirl.create(:document) }
  let(:game) { FactoryGirl.create(:game, document: document) }

  before do
    login_as(user)
  end

  context 'when visit the game page' do

    context 'as a judge' do
      before do
        assign_role!(user, :judge, game, ROUND, SCORE)
        @game_player = GamePlayer.find_by(user: user)
        visit game_path(game)
      end

      it 'should see attibutes but no Questioner' do
        within("#attributes") do
          expect(page).not_to have_content "Questioner of this round: "
          expect(page).to have_content "judge"
          expect(page).to have_content @game_player.round.to_s
          expect(page).to have_content @game_player.score.to_s
        end
      end

      it 'should see reading text' do
        within("#document") do
          within("header h2") do
            expect(page).to have_content "Reading Text"
          end

          within(".document") do
            expect(page).to have_content "dummy title"
            expect(page).to have_content "This is a single dummy document meant to be tested by rspec.
            This document should not be used under any other conditions."
          end
        end
      end
    end

    context 'as a reader' do
      before do
        assign_role!(user, :reader, game, ROUND, SCORE)
        @game_player = GamePlayer.find_by(user: user)
        visit game_path(game)
      end

      it 'should see attributes' do
        within("#attributes") do
          expect(page).to have_content "Questioner of this round: "
          expect(page).to have_content "reader"
          expect(page).to have_content @game_player.round.to_s
          expect(page).to have_content @game_player.score.to_s
        end
      end

      it 'should see reading text' do
        within("#document") do
          within("header h2") do
            expect(page).to have_content "Reading Text"
          end

          within(".document") do
            expect(page).to have_content "dummy title"
            expect(page).to have_content "This is a single dummy document meant to be tested by rspec.
            This document should not be used under any other conditions."
          end
        end
      end
    end

    context 'as a guesser' do
      before do
        assign_role!(user, :guesser, game, ROUND, SCORE)
        @game_player = GamePlayer.find_by(user: user)
        visit game_path(game)
      end

      it 'should see attributes' do
          within("#attributes") do
          expect(page).to have_content "Questioner of this round: "
          expect(page).to have_content "guesser"
          expect(page).to have_content @game_player.round.to_s
          expect(page).to have_content @game_player.score.to_s
        end
      end

      it 'should not see reading text' do
        expect(page).not_to have_selector "#document"
        expect(page).not_to have_content "Reading Text"

        expect(page).not_to have_content "dummy title"
        expect(page).not_to have_content "This is a single dummy document meant to be tested by rspec.
        This document should not be used under any other conditions."
      end
    end
  end

end
