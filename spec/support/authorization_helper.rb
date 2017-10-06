module AuthorizationHelpers
  def assign_role!(user, role, game, round: 42, score: 1024, questioner: false)
    GamePlayer.where(user: user, game: game).delete_all
    GamePlayer.create!(user: user, role: role, game: game, round: round, score: score, questioner: questioner)
  end
end

RSpec.configure do |c|
  c.include AuthorizationHelpers
end
