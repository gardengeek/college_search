require "rails_helper"

describe SearchDecorator do
  let(:college_search_results) do
    [
      {"school.name"=>"Choffin Career  and Technical Center", "school.state"=>"OH", "id"=>201803, "location.lat"=>41.100847, "location.lon"=>-80.644393},
      {"school.name"=>"Northeast Ohio Medical University", "school.state"=>"OH", "id"=>204477, "location.lat"=>41.102919, "location.lon"=>-81.245302},
      {"school.name"=>"Ohio Institute of Allied Health", "school.state"=>"OH", "id"=>483647, "location.lat"=>39.84549, "location.lon"=>-84.14076},
      {"school.name"=>"Ohio State University-Newark Campus", "school.state"=>"OH", "id"=>204705, "location.lat"=>40.069314, "location.lon"=>-82.447441}
    ]
  end

  describe "#google_map_image" do
    it "returns the google map image for the schools" do
      markers = [
        "markers=label:A|41.100847,-80.644393",
        "markers=label:B|41.102919,-81.245302",
        "markers=label:C|39.84549,-84.14076",
        "markers=label:D|40.069314,-82.447441"
      ]
      image_map = "https://maps.googleapis.com/maps/api/staticmap?#{markers.join('&')}&size=500x400&key=#{ ENV["GOOGLE_MAPS_API_KEY"] }"


      expect(described_class.new(college_search_results: college_search_results).google_map_image)
        .to eq(image_map)
    end
  end

  describe "#legend" do
    it "returns the legend for the google markers" do
      legend = [
        {:letter=>"A", :name=>"Choffin Career  and Technical Center"},
        {:letter=>"B", :name=>"Northeast Ohio Medical University"},
        {:letter=>"C", :name=>"Ohio Institute of Allied Health"},
        {:letter=>"D", :name=>"Ohio State University-Newark Campus"}
      ]
      expect(described_class.new(college_search_results: college_search_results).legend)
        .to match_array(legend) 
    end
  end
end
