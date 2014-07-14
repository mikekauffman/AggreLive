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
    redirect_to "/search/#{search.url_safe_term}/1"
  end

  def show
    search_term = params[:term].gsub('+', " ")
    @search = Search.find_by(term: search_term)
    city_search = CitySearch.new
    city_id = city_search.id_for(search_term)
    event_search = EventSearch.new
    @current_page = params[:page_number].to_i
    @concerts = event_search.concerts_in(city_id, @current_page)
  end

end