class CitySearch
  class CityNotFoundError < StandardError;
  end

  def initialize
    @api_endpoint = "http://api.songkick.com/api/3.0/search/locations.json?query=%s&apikey=#{ENV['API_KEY']}"
  end

  def id_for(search_term)
    response = JSON.parse(Faraday.get(sprintf(@api_endpoint, search_term)).body)
    if response["resultsPage"]["results"].empty?
      raise(CityNotFoundError)
    else
      response["resultsPage"]["results"]["location"][0]["metroArea"]["id"]
    end
  end

end

