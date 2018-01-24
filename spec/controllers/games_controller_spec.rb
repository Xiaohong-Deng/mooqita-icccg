require "rails_helper"

RSpec.describe GamesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:document) { FactoryBot.create(:document) }
  let(:game) { FactoryBot.create(:game, document: document) }

  before do
    sign_in user
  end

  it 'handles a missing game correctly' do
    get :show, params: { id: "not-there" }

    expect(response).to redirect_to root_path
    message = "The game you were looking for could not be found."
    expect(flash[:alert]).to eq message
  end

  it 'handles permission errors by redirecting' do
    allow(controller).to receive :current_user

    get :show, params: { id: game }

    expect(response).to redirect_to root_path
    message = "You are not allowed to do that."
    expect(flash[:alert]).to eq message
  end
end
