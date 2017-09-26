class GameChannel < ApplicationCable::Channel
  before_subscribe :set_game_and_player

  def subscribed
    stream_for current_user
    stream_from "game-#{params['game']}: questions"
    stream_from "game-#{params['game']}: answers"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(payload)
    # receive from actioncable js client side code
    # could be question or answer
    # it depends on js code to send a single key hash
    model_name = payload.first[0].to_s.classify.constantize
    round = @game_player.round
    attributes = {game_id: params['game'], round: round, content: payload.first[1]}
    if question = @game.questions.find_by(round: round)
      attributes[:question_id] = question.id
    end
    attributes.select! { |x| model_name.attribute_names.index(x.to_s) }
    attributes[:user] = current_user
    model_name.create(attributes)
  end

  private
    def set_game_and_player
      @game = Game.find(params['game'])
      @game_player = @game.game_players.find_by(user: current_user)
    end
end
