class SearchesController < ApplicationController

  def create
    search_term = params[:search_term].delete(',')
    if current_user
      search = Search.new(
        term: search_term,
        user_id: current_user.id
      )
    else
      search = Search.new(
        term: search_term
      )
    end
    search.save
    redirect_to "/search/#{search.url_safe_term}"
  end

  def show
    search_term = params[:term].gsub('+', " ")
    @search = Search.find_by(term: search_term)
    city_search = CitySearch.new(search_term)
    events = city_search.get_events(city_search.get_id)
    concerts = []
    events.each do |concert|
      concert_hash = city_search.concert_hash(concert)
      concerts << concert_hash if !concert_hash[:date].nil?
    end
    @concerts = concerts
  end

end