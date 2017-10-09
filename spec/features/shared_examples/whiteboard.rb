RSpec.shared_examples "whiteboard" do
  it 'should see the whiteboard content' do
    within(".titles") do
      expect(page).to have_content "Whiteboard"
    end

    within("#whiteboard") do
      expect(page).to have_content "Did you eat anything yesterday?"
      expect(page).to have_content "I ate yesterday"
    end
  end
end
