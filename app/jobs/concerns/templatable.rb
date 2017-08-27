module Templatable
  def game_starting(game)
    {
      target: '.main-container',
      template: render('starting', {game_id: game.id})
    }
  end

  def game_waiting
    {
      target: '.main-container',
      template: render('waiting', {participants_size: GameWaitingRoom.participants_size})
    }
  end

  def participants_size
    {target: '.status span', template: GameWaitingRoom.participants_size}
  end

  def render(name, locals)
    GamesController.render(partial: "games/#{name}", locals: locals)
  end
end
