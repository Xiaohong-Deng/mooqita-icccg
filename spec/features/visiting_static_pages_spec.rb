require "rails_helper"

RSpec.feature "User can visit static pages" do
  it 'should get home' do
    visit root_path

    expect(page).to have_content("Welcome to Iterative Crowdsourcing Comprehension Challenge Game!")
    expect(page).to have_title("Home | ICCCG")
  end
end
