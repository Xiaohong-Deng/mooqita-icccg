RSpec.shared_examples "whiteboard" do
  it 'should see the whiteboard content' do
    within(".titles") do
      expect(page).to have_content "Whiteboard"
    end
  end
end
