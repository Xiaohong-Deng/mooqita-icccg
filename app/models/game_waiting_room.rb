class GameWaitingRoom
  attr_reader :queue

  def initialize(queue: Redis::Unique::Queue.new('game_waiting_room', Redis.new(url: ActionCable.server.config.cable[:url])))
    @queue = queue
  end

  def add(user)
    queue.push user.id
  end

  def remove(user)
    queue.remove user.id
  end

  def full?
    participants_size == GAME_SIZE
  end

  def users_ids
    queue.pop_all.map(&:to_i)
  end

  def participants_size
    queue.size
  end

  class << self
    instance_methods = GameWaitingRoom.instance_methods(false)
    delegate(*instance_methods, to: :room)

    def room
      @room ||= new
    end
  end
end
