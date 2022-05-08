require "rails_helper"

describe FindColleges do
  describe "::perform" do
    let(:filter) { "school.name=foo" }
    let(:return_params) { "fields=id,school.name,school.state,location.lat,location.lon" }
    let(:url) { "https://api.data.gov/ed/collegescorecard/v1/schools.json?#{return_params}&#{filter}" }

    it "calls the College Scorecard API and returns the schools" do
      stub_request(:get, url).
        to_return(status: 200, headers: [], body: "bar")

      result = described_class.new(search_term: "foo").perform
      expect(result).to eq("bar")
    end

    describe "College Scorecard returns an error" do
      it "returns the error" do
        stub_request(:get, url).
          to_return(status: 400, headers: [], body: "error")

        result = described_class.new(search_term: "foo").perform
        expect(result).to eq({ error: "400 Bad Request" })
      end
    end
  end
end
