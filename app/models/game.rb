class Game < ApplicationRecord
  has_many :game_players, dependent: :destroy
  has_many :players, through: :game_players, source: :user
  has_many :questions, dependent: :nullify
  belongs_to :document

  enum status: [:active, :paused]

  def self.create_with_users_ids(ids)
    # if validation fails Game.find(game.id) wont find anything
    # but create returns an invalid game object
    document = Document.random_fetch
    unless document
      # return nil indicating game creating failure
      return document
    end
    game = Game.create(document: document)
    roles_shuffled = GAME_ROLES.map(&:to_s).shuffle
    game_players = game.game_players

    ids.zip(roles_shuffled).each do |id, role|
      game_players.create(user_id: id, role: role)
    end

    questioner.set_questioner

    game
  end

  def set_next_questioner
    questioner.set_next_questioner
  end

  def round_end_for?(user)
    player_round = game_players.find_by(user: user).round
    # if question exists and there is a answer marked true for it
    # then this round is ended, otherwise not
    if question = questions.find(round: player_round)
      question.answers.find(judge_choice: true)
    else
      question
    end
  end

  def has_member?(user)
    game_players.exists?(user_id: user)
  end

  def has_questioner?(user)
    game_players.exists?(user_id: user, questioner: true)
  end

  GAME_ROLES.each do |role|
    define_method "has_#{role}?" do |user|
      game_players.exists?(user_id: user, role: role)
    end
  end

  private
    def questioner
      game_players.exclude_role("judge").shuffle[0]
    end
end
