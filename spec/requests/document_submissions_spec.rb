require 'spec_helper'

describe "DocumentSubmissions" do
  describe "GET /document_submissions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get document_submissions_path
      expect(response.status).to be(200)
    end
  end
end
