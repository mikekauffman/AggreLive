class Event < ActiveRecord::Base
  belongs_to :user

  def self.get_info(event_id)
    data = JSON.parse(Faraday.get("http://api.songkick.com/api/3.0/events/#{event_id}.json?apikey=#{ENV['API_KEY']}").body)["resultsPage"]["results"]["event"]
    date = (data["start"]["datetime"]).to_datetime if data["start"]["datetime"]
    h = {}
    h[:id] = event_id
    h[:date] = data["start"]["datetime"] if date
    h[:date_day] = date.strftime('%-d') if date
    h[:date_month] = date.strftime('%^b') if date
    h[:date_year] = date.strftime('%Y') if date
    h[:artist] = data["performance"][0]["artist"]["displayName"]
    h[:tag_line] = data["displayName"]
    h[:url] = data["uri"]
    h
  end

  def date_day
    date.to_datetime.strftime('%-d')
  end

  def date_month
    date.to_datetime.strftime('%^b')
  end

  def date_year
    date.to_datetime.strftime('%Y')
  end
end