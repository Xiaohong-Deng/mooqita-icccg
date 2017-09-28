class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, except: [:judge]
  before_action :set_game_player, except: [:judge]
  before_action :set_document, except: [:judge]
  before_action :set_current_qa, except: [:judge]

  def show
    authorize @game
    @question ||= Question.new
    @answer = Answer.new
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

    def judge_params
      # params.require()
    end
end
