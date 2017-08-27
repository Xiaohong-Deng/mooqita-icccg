require 'rails_helper'

RSpec.describe GameWaitingRoom, type: :model do
  before { GameWaitingRoom.users_ids }

  describe '.add' do
    it "adds the user's id to the queue" do
      user = double('User', id: 1)
      GameWaitingRoom.add(user)

      expect(GameWaitingRoom.queue.front).to eq '1'
    end
  end
end
