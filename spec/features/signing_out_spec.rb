require "rails_helper"

RSpec.feature 'Signed-in users can sign out' do
  let!(:user) { FactoryBot.create(:user) }

  before do
    login_as(user)
  end

  scenario do
    visit root_path
    click_link "Log out"
    expect(page).to have_content("Signed out successfully.")
  end
end
