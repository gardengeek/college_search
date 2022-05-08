require "rails_helper"

describe FindColleges do
  describe "::perform" do
    it "calls the College Scorecard API and returns the schools" do
      filter = "school.name=foo"
      return_params = "fields=id,school.name,school.state,location.lat,location.lon"
      url = "https://api.data.gov/ed/collegescorecard/v1/schools.json?#{return_params}&#{filter}"
      stub_request(:get, url).
        to_return(status: 200, headers: [], body: "bar")

      result = described_class.new(search_term: "foo").perform
      expect(result).to eq("bar")
    end
  end
end
