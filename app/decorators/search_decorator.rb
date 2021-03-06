class SearchDecorator
  extend PrivateAttr
  private_attr_reader :college_search_results, :markers
  attr_reader :legend

  def initialize(college_search_results:)
    @college_search_results = college_search_results
    @markers = []
    @legend = []
    set_google_markers_and_legend
  end

  def google_map_image
    "https://maps.googleapis.com/maps/api/staticmap?#{markers.join('&')}&size=500x400&key=#{ google_api_key }"
  end

  private

  def set_google_markers_and_legend
    college_search_results.each_with_index do |s, i|
      letter = (65 + i).chr
      @markers << "markers=label:#{letter}|#{s['location.lat']},#{s['location.lon']}"
      @legend << { letter: letter, name: s['school.name'] }
    end
  end

  def google_api_key
    ENV["GOOGLE_MAPS_API_KEY"]
  end
end
