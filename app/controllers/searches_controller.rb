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
    city_search = CitySearch.new
    city_id = city_search.id_for(search_term)
    event_search = EventSearch.new
    @concerts = event_search.concerts_in(city_id)
    @current_page = 1
  end

  def next_page
    search_term = params[:search_term].gsub('+', " ")
    @search = Search.find_by(term: search_term)
    city_search = CitySearch.new
    city_id = city_search.id_for(search_term)
    event_search = EventSearch.new
    @concerts = event_search.paginated_concerts(city_id, params[:page_number])
    @current_page = params[:page_number].to_i
    render 'searches/show'
  end

end