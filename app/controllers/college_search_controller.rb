class CollegeSearchController < ApplicationController
  def college_search
  end

  def search
    data = JSON.parse(FindColleges.new(search_term: params[:query]).perform)
    if data["error"]
      @error = data["error"]
    else
      @decorator = SearchDecorator.new(college_search_results: data["results"])
    end
  end
end
