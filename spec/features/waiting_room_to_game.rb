# require "rails_helper"

# RSpec.describe "Players can enter the game through waiting room" do
#   let(:user1) { FactoryGirl.create(:user, email: "user1@example.com", password: "topsecret") }
#   let(:user2) { FactoryGirl.create(:user, email: "user2@example.com", password: "topsecret") }
#   let(:user3) { FactoryGirl.create(:user, email: "user3@example.com", password: "topsecret") }

#   scenario 'should allow 3 users to enter the room and be redirect to game page', js: true do
#     Capybara.session_name = "user1"
#     login_as(user1)
#     visit root_path
#     click_link "Play Game"
#     expect(page).to have_content "There are currently 1 players waiting"
#     Capybara.session_name = "user2"
#     login_as(user2)
#     visit root_path
#     click_link "Play Game"
#     expect(page).to have_content "There are currently 2 players waiting"
#     Capybara.session_name = "user3"
#     login_as(user3)
#     visit root_path
#     click_link "Play Game"
#     expect(page).to have_content "We have 3 players. redirecting to game...."
#   end
# end
