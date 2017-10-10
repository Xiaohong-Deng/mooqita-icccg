class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game
  before_action :set_game_data

  def show
    authorize @game
    @question ||= Question.new
    @answer = Answer.new
    @is_end = @game.round_end_for? current_user
  end

  def update
    authorize @game
    round = @game_player.round + 1

    if is_questioner = @game_player.next_questioner
      @game_player.reset_next_questioner
    end

    if @game_player.scored?
      flash[:notice] = "<strong>Congratulations!</strong> You gained a point in the last round."
      new_score = @game_player.score + 1
    else
      flash[:error] = "<strong>Sorry!</strong> You lost a point in the last round."
      new_score = @game_player.score - 1
    end

    if @game_player.update(round: round, score: new_score, questioner: is_questioner)
      redirect_to game_path
    else
      flash.clear
      flash[:alert] = "You failed to enter the next round"
      redirect_to root_path
    end
  end

  def judge
    authorize @game
    render layout: false
  end

  private
    def set_game
      @game = Game.find(params[:id])
    end

    def set_game_data
      @game_player = @game.game_players.find_by(user: current_user)

      unless @game_player.try(:role) == "guesser"
        @document = @game.document
      end

      @question = Question.find_by(game: @game, round: @game_player.try(:round))
      @answers = @question.answers if @question
    end
end
