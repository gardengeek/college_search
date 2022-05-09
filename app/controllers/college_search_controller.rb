class CollegeSearchController < ApplicationController
  def college_search
    if params[:query].present?
      data = FindColleges.new(search_term: params[:query]).perform
      if data[:error].present?
        @error = data[:error]
      else
        @decorator = SearchDecorator.new(college_search_results: data["results"])
      end
    end
  end
end
