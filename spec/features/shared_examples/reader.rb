RSpec.shared_examples "reader" do
  it 'should see the document content' do
    within(".titles") do
      expect(page).to have_content "Document"
    end

    within(".doc-info") do
      expect(page).to have_content "dummy title"
      expect(page).to have_content "This is a single dummy document meant to be tested by rspec.
      This document should not be used under any other conditions."
    end
  end
end
