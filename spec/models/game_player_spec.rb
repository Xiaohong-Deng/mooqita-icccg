require 'rails_helper'

RSpec.describe GamePlayer, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:document) { FactoryBot.create(:document) }
  let(:game) { FactoryBot.create(:game, document: document) }

  it 'should be able to set its questioner' do
    game_player = GamePlayer.create(game: game, user: user)
    expect(game_player.questioner?).to eq false

    game_player.set_questioner
    game_player.reload

    expect(game_player.questioner?).to eq true
  end
end
