# it's a non persistent model, no migration corresponding to it
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
    # instance methods that are not inherited from ancestors
    instance_methods = GameWaitingRoom.instance_methods(false)
    # in this scope self is class GameWaitingRoom
    # delegate here delegates all the self.instance_methods
    # to self.room, e.g. GameWaitingRoom.participants_size is equal to
    # GameWaitingRoom.room.participants_size
    delegate(*instance_methods, to: :room)

    def room
      # again new is self.new, which is GameWaitingRoom.new
      @room ||= new
    end
  end
end
