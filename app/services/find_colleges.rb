require "rest-client"
# Service to take a search term and call the College Search API
# to get colleges that match
class FindColleges
  extend PrivateAttr
  private_attr_reader :search_term

  def initialize(search_term:)
    @search_term = search_term
  end

  def perform
    api_response = RestClient.get(college_search_url, headers)
    api_response.body
  end

  private

  def college_search_url
    "https://api.data.gov/ed/collegescorecard/v1/schools.json?#{filter}&#{returned_fields}"
  end

  def filter
    "school.name=#{search_term}"
  end

  def returned_fields
    "fields=id,school.name,school.state,location.lat,location.lon"
  end

  def headers
    {
      "X-Api-Key": api_key
    }
  end

  def api_key
    ENV["COLLEGE_SCORECARD_API_KEY"]
  end
end
