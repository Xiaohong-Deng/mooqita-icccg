class GameChannelContext
  attr_reader :user, :game

  def initialize(user, game)
    @user = user
    @game = game
  end
end
