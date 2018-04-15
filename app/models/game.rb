class Game < ApplicationRecord
  has_many :game_players, dependent: :destroy
  has_many :players, through: :game_players, source: :user
  has_many :questions, dependent: :nullify
  belongs_to :document

  enum status: [:active, :paused]
  # delegate set_next_questioner to the return value of next_questioner
  # which is a GamePlayer, next_questioner is reset once judge makes his choice
  delegate :set_next_questioner, to: :next_questioner

  def self.create_with_users_ids(ids)
    # if validation fails Game.find(game.id) wont find anything
    # but create returns an invalid game object
    document = Document.random_fetch
    unless document
      # return nil indicating game creating failure
      return document
    end
    game = Game.create!(document: document)
    roles_shuffled = GAME_ROLES.map(&:to_s).shuffle
    game_players = game.game_players
    ids.zip(roles_shuffled).each do |id, role|
      game_players.create!(user_id: id, role: role)
    end

    next_questioner(game).set_questioner

    game
  end

  def round_end_for?(user)
    player_round = player_for(user).round
    # if question exists and there is a answer marked true for it
    # then this round is ended, otherwise not
    if question = questions.find_by(round: player_round)
      question.answers.exists?(judge_choice: true)
    end
  end

  def player_for(user)
    game_players.find_by(user: user)
  end

  def has_member?(user)
    game_players.exists?(user_id: user)
  end

  def has_questioner?(user)
    game_players.exists?(user_id: user, questioner: true)
  end

  def has_question_for?(round)
    questions.exists?(round: round)
  end

  GAME_ROLES.each do |role|
    define_method "has_#{role}?" do |user|
      game_players.exists?(user_id: user, role: role)
    end
  end

  def past_questions(round)
    questions.where("round < ?", round)
  end

  private
    def self.next_questioner(game)
      game.game_players.exclude_role("judge").shuffle[0]
    end

    def next_questioner
      game_players.exclude_role("judge").shuffle[0]
    end
end
