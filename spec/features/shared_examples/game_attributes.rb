RSpec.shared_examples "general_attributes" do |role|
  scenario 'can see general attributes' do
    within("#attributes") do
      expect(page).to have_content "#{role}"
      expect(page).to have_content @game_player.round.to_s
      expect(page).to have_content @game_player.score.to_s
    end
  end
end

RSpec.shared_examples "questioner" do
  scenario 'can see questioner' do
    within("#attributes") do
      expect(page).to have_content "Questioner of this round: "
    end
  end
end

RSpec.shared_examples "not questioner" do
  scenario 'can not see questioner' do
    within("#attributes") do
      expect(page).not_to have_content "Questioner of this round: "
    end
  end
end

RSpec.shared_examples "game_attributes" do |role, questioner_role|
  include_examples 'general_attributes', role
  include_examples questioner_role
end
