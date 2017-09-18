require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '.create_with_users_ids' do
    it 'creates a new game' do
      Game.create_with_users_ids([])

      expect(Game.all.size).to eq 1
    end

    context 'ids given' do
      before do
        @user1 = User.create(email: "user1@example.com", password: "topsecret")
        @user2 = User.create(email: "user2@example.com", password: "topsecret")

        @game = Game.create_with_users_ids([@user1.id, @user2.id])
      end

      it 'adds each user that matches id to the game' do
        expect(@game.players.to_a).to include(@user1, @user2)
      end

      it 'assign each user different roles' do
        game_player1 = @game.game_players.first
        game_player2 = @game.game_players.second
        roles = GAME_ROLES.to_s

        expect(roles).to include(game_player1.role)
        expect(roles).to include(game_player2.role)
      end
    end
  end
end
