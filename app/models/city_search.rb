class CitySearch
  def initialize(search_term)
    @response = JSON.parse(Faraday.get("http://api.songkick.com/api/3.0/search/locations.json?query=#{search_term}&apikey=#{ENV['API_KEY']}").body)
  end

  def get_id
    @response["resultsPage"]["results"]["location"][0]["metroArea"]["id"]
  end

  def get_events(city_id)
    events = JSON.parse(Faraday.get("http://api.songkick.com/api/3.0/metro_areas/#{city_id}/calendar.json?apikey=#{ENV['API_KEY']}").body)
    concerts = []
    events["resultsPage"]["results"]["event"].each do |event|
      concerts << event if event["type"] == "Concert"
    end
    concerts
  end

  def concert_hash(concert)
    h = {}
    date = (concert["start"]["datetime"]).to_datetime if concert["start"]["datetime"]
    h[:id] = concert["id"]
    h[:date] = concert["start"]["datetime"]
    h[:popularity] = concert["popularity"]
    h[:tag_line] = concert["displayName"][0..-16]
    h[:date_month] = date.strftime('%^b') if date
    h[:date_day] = date.strftime('%-d') if date
    h[:date_year] = date.strftime('%Y') if date
    h[:url] = concert["uri"]
    h[:artist] = concert["performance"][0]["artist"]["displayName"]
    h[:artist_url] = concert["performance"][0]["artist"]["uri"]
    h[:venue] = concert["venue"]["displayName"]
    h[:venue_url] = concert["venue"]["uri"]
    h
  end

end