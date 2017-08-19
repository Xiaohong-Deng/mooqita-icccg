require "rails_helper"

RSpec.feature 'Users can sign in' do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'with valid credential' do
    visit root_path
    click_link "Log in"
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_link("Log out")
  end
end
