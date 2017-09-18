require "rails_helper"

RSpec.describe 'Players can play the game' do
  let(:user) { FactoryGirl.create(:user) }
  let(:game) { FactoryGirl.create(:game) }
  let(:game_player) { FactoryGirl.create(:game_player, game: game) }

  before do
    login_as(user)
  end

  context 'for judge' do
    before do
      assign_role!(game_player, :judge)
    end

    context 'when they visit the first page in the gaming cycle' do
      it 'should see their roles' do
        visit
      end
    end
  end

end
