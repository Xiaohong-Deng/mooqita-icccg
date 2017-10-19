class GameChannel < ApplicationCable::Channel
  include Pundit
  before_subscribe :set_game_and_player

  def subscribed
    stream_from "game-#{params['game']}: questions"
    stream_from "game-#{params['game']}: answers"
    stream_from "game-#{params['game']}: info"
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
    # it checks the number of questions or answers created in this round
    # if questions more than 0 or answers more than 1 for a user, reject
    model_instance = model_name.new model_params(model_name, content)
    authorize model_instance, :create?
    unless model_instance.save
      ActionCable.server.broadcast "game-#{@answer.question.game_id}: info",
        { message: "#{model_name.to_s} has not been submitted.", message_type: "info" }
      # do something to show text area again? coffee should be the one to do it
    end
  end
  # in order to use extra parameter '@game' in pundit
  # create a wrapper called 'GameChannelContext'

  private
    def set_game_and_player
      @game = Game.find(params['game'])
      @game_player = @game.game_players.find_by(user: current_user)
    end

    def model_params(model_name, content)
      round = @game_player.round
      model_params = {game_id: params['game'], round: round, content: content}
      if question = @game.questions.find_by(round: round)
        model_params[:question_id] = question.id
      end
      model_params.select! { |x| model_name.attribute_names.index(x.to_s) }
      model_params[:user] = current_user
      model_params
    end
end
