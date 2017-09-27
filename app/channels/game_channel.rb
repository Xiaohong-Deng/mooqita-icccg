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
    # with key being the correct model name
    payload_pair = payload.first
    model_name = payload_pair[0].to_s.classify.constantize
    content = payload_pair[1]
    model_name.create model_params(model_name, content)
  end

  private
    def set_game_and_player
      @game = Game.find(params['game'])
      @game_player = @game.game_players.find_by(user: current_user)
    end

    def model_params(model_name, content)
      round = @game_player.round
      params = {game_id: params['game'], round: round, content: content}
      if question = @game.questions.find_by(round: round)
        params[:question_id] = question.id
      end
      params.select! { |x| model_name.attribute_names.index(x.to_s) }
      params[:user] = current_user
      params
    end
end
