module AuthorizationHelpers
  def assign_role!(user, role, game, round, score)
    GamePlayer.where(user: user, game: game).delete_all
    GamePlayer.create!(user: user, role: role, game: game, round: 42, score: 1024)
  end
end

RSpec.configure do |c|
  c.include AuthorizationHelpers
end
