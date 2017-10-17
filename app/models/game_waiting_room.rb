# it's a non persistent model, no migration corresponding to it
class GameWaitingRoom
  attr_reader :queue

  def initialize(queue: Set.new)
    @queue = queue
  end

  def add(user)
    queue.add user.id
  end

  def remove(user)
    queue.delete user.id
  end

  def full?
    participants_size == GAME_SIZE
  end

  def users_ids
    ids = queue.to_a
    queue.clear
    ids
  end

  def participants_size
    queue.size
  end

  class << self
    # instance methods that are not inherited from ancestors
    instance_methods = GameWaitingRoom.instance_methods(false)
    # by default 'delegate' delegates all the instance_methods
    # to room. Both are considered instance methods in this scope
    # In this scope, self for instance methods is class GameWaitingRoom
    # self for self.method is singleton class for GameWaitingRoom
    delegate(*instance_methods, to: :room)

    def room
      # again new is self.new, which is GameWaitingRoom.new
      @room ||= new
    end
  end
end
