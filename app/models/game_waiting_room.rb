class GameWaitingRoom
  class << self
    def add(user)
      queue.push user.id
    end

    def remove(user)
      queue.remove user.id
    end

    def full?
      queue.size == GAME_SIZE
    end

    def users_ids
      queue.pop_all.map(&:to_i)
    end

    def participants_size
      queue.size
    end

    private

    def queue
      @queue ||= Redis::Unique::Queue.new('game_waiting_room')
    end
  end
end
