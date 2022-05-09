class CollegeSearchController < ApplicationController
  def college_search
  end

  def search
    data = JSON.parse(FindColleges.new(search_term: params[:query]).perform)
    @markers = []
    @legend = []
    data['results'].each_with_index do |s, i|
      letter = (65 + i).chr
      @markers << "markers=label:#{letter}|#{s['location.lat']},#{s['location.lon']}"
      @legend << { letter: letter, name: s['school.name'] }
    end
  end
end
