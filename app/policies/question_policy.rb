class QuestionPolicy < ApplicationPolicy
  attr_reader :user, :record, :game

  def initialize(context, record)
    @user = context.user
    @game = context.game
    @record = record
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    game_player = game.game_players.find_by(user: user)
    game_player.questioner? && Question.find_by(game: game, round: game_player.round).nil?
  end
end
