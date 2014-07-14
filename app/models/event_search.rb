class EventSearch
  def concerts_in(city_id, page_number)
    events = JSON.parse(Faraday.get("http://api.songkick.com/api/3.0/metro_areas/#{city_id}/calendar.json?apikey=#{ENV['API_KEY']}&page=#{page_number}").body)
    concerts = events["resultsPage"]["results"]["event"].select { |event| event["type"] == "Concert" && !event["start"]["datetime"].nil? }
    concerts.map do |concert|
      h = {}
      date = concert["start"]["datetime"]
      h[:date] = date
      h[:date_day] = date.to_datetime.strftime('%-d').to_i if date
      h[:date_month] = date.to_datetime.strftime('%^b') if date
      h[:date_year] = date.to_datetime.strftime('%Y').to_i if date
      h[:tag_line] = tag_line_parser(concert["displayName"])
      h[:url] = concert["uri"]
      h[:id] = concert["id"]
      h[:artist] = concert["performance"][0]["displayName"]
      h
    end
  end

  def tag_line_parser(tag_line)
    if tag_line.include?('(CANCELLED)')
      tag_line.split[0..-5].join(" ")
    else
      tag_line.split[0..-4].join(" ")
    end
  end
end