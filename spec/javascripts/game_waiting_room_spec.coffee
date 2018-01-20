describe 'window.startGameWaitingRoomCable', ->
  beforeAll ->
    fixture.load "game_waiting_room_spec.html"
    window.startGameWaitingRoomCable()

  it 'should create a subscription', ->
    expect(App.game.identifier).toEqual '{"channel":"GameWaitingRoomChannel"}'

  it 'should be able to render template', ->
    data = {
            target: ".waiting-room-mocks",
            template: "<div class='waiting-room-stubs'>Welcome to waiting room stubs!<div>"
            }
    expect($(".waiting-room-mocks").text()).toContain "Welcome to waiting room mocks!"
    App.game.renderTemplate(data)
    expect($(".waiting-room-stubs").text()).toContain "Welcome to waiting room stubs!"
