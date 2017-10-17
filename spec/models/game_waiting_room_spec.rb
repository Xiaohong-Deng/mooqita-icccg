require 'rails_helper'

RSpec.describe GameWaitingRoom, type: :model do
  let(:queue) { Set.new }
  let(:game_waiting_room) { GameWaitingRoom.new(queue: queue) }

  (1..3).each do |n|
    let("user#{n}".to_sym) { double('User', id: n) }
  end

  before do
    queue.clear
  end

  describe '.room' do
    it 'returns a instance of GameWaitingRoom' do
      expect(GameWaitingRoom.room).to be_a GameWaitingRoom
    end
  end

  describe 'class methods' do
    it 'has all instance_methods' do
      expect(GameWaitingRoom.methods(false)).to include(*GameWaitingRoom.instance_methods(false))
    end
  end

  describe '#add' do
    it "adds the user's id to the queue" do
      game_waiting_room.add(user1)

      expect(queue).to include 1
    end

    it 'adds another user to the same queue' do
      game_waiting_room.add(user1)
      game_waiting_room.add(user2)

      expect(queue).to include 1, 2
    end

    context 'same user added twice' do
      it 'will only add one time' do
        2.times { game_waiting_room.add(user1) }

        expect(queue.size).to eq 1
      end
    end
  end

  describe '#remove' do
    it "removes a user's id from the queue" do
      game_waiting_room.add(user1)
      game_waiting_room.remove(user1)

      expect(queue).to be_empty
    end
  end

  describe '#full?' do
    it 'returns true when queue size is equal to game size' do
      GAME_SIZE.times do |n|
        game_waiting_room.add(double('User', id: n))
      end

      expect(game_waiting_room).to be_full
    end
  end

  describe '#users_ids' do
    it 'returns all user ids from the queue' do
      game_waiting_room.add(user1)
      game_waiting_room.add(user2)

      ids = game_waiting_room.users_ids

      expect(ids).to include 1
      expect(ids).to include 2
      expect(ids.size).to eq 2
    end

    it 'casts the ids to integer' do
      game_waiting_room.add(user1)
      game_waiting_room.add(user2)

      expect(game_waiting_room.users_ids).to all be_a Integer
    end

    it 'removes the ids from queue' do
      game_waiting_room.add(user1)
      game_waiting_room.add(user2)
      game_waiting_room.users_ids

      expect(queue).to be_empty
    end
  end

  describe '#participants_size' do
    it 'returns the size of participants in the room' do
      game_waiting_room.add(user1)
      game_waiting_room.add(user2)

      expect(game_waiting_room.participants_size).to be 2
    end
  end
end
