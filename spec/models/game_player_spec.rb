require 'rails_helper'

RSpec.describe GamePlayer, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:document) { FactoryGirl.create(:document) }
  let(:game) { FactoryGirl.create(:game, document: document) }

  it 'should be able to set its questioner' do
    game_player = GamePlayer.create(game: game, user: user)
    expect(game_player.questioner?).to eq false

    game_player.set_questioner
    game_player.reload

    expect(game_player.questioner?).to eq true
  end
end
