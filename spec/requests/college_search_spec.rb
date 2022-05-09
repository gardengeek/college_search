require "rails_helper"

describe CollegeSearchController do
  describe "GET #college_search" do
    context "when params[:query] does not have a value" do
      it "does not call the service or decorator" do
        expect(FindColleges).not_to receive(:new)
        expect(SearchDecorator).not_to receive(:new)

        get college_search_path, params: {}
      end
    end

    context "when params[:query] has a value" do
      let(:legend) do
        [
          {:letter=>"A", :name=>"Choffin Career  and Technical Center"},
          {:letter=>"B", :name=>"Northeast Ohio Medical University"},
          {:letter=>"C", :name=>"Ohio Institute of Allied Health"},
          {:letter=>"D", :name=>"Ohio State University-Newark Campus"}
        ]
      end
      let(:markers) do
        [
          "markers=label:A|41.100847,-80.644393",
          "markers=label:B|41.102919,-81.245302",
          "markers=label:C|39.84549,-84.14076",
          "markers=label:D|40.069314,-82.447441"
        ]
      end

      context "when service returns results" do
        it "sets @decorator" do
          service = instance_double(FindColleges)
          expect(FindColleges).to receive(:new).with(search_term: "foo")
            .and_return(service)
          response = { results: { foo: "bar" } }
          expect(service).to receive(:perform).and_return(response)

          decorator = instance_double(SearchDecorator, legend: legend, markers: markers)
          expect(SearchDecorator).to receive(:new).and_return(decorator)

          get college_search_path, params: { query: "foo" }

          expect(assigns[:decorator]).to eq(decorator)
        end
      end

      context "when service returns an error" do
        it "sets @error" do
          service = instance_double(FindColleges)
          expect(FindColleges).to receive(:new).with(search_term: "foo")
            .and_return(service)
          response = { error: "Something went wrong" }
          expect(service).to receive(:perform).and_return(response)
          expect(SearchDecorator).not_to receive(:new)

          get college_search_path, params: { query: "foo" }

          expect(assigns[:error]).to eq("Something went wrong")
        end
      end
    end
  end
end
