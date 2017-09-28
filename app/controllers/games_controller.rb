class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game
  before_action :set_game_player
  before_action :set_document, except: [:judge]
  before_action :set_current_qa

  def show
    authorize @game
    @question ||= Question.new
    @answer = Answer.new
    @is_end = round_end?
  end

  def update
    authorize @game
    round = @game_player.round + 1
    if @game_player.update(round: round)
      flash[:notice] = "You successfully entered the next round"
      redirect_to game_path
    else
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

    def set_game_player
      @game_player = @game.game_players.find_by(user: current_user)
    end

    def set_document
      unless @game_player.role == "guesser"
        @document = @game.document
      end
    end

    def set_current_qa
      @question = Question.find_by(game: @game, round: @game_player.round)
      @answers = @question.answers if @question
    end

    def round_end?
      @answers && @answers.exists?(judge_choice: true)
    end
end
