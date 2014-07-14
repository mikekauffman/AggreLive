require 'spec_helper'

describe EventSearch do
  it 'gets events for a city' do
    VCR.use_cassette('concert_info_test') do
      event_search = EventSearch.new
      concerts = event_search.concerts_in(6404)
      expected_concert = {
        date: "2014-07-13T20:00:00-0600",
        tag_line: "Searson at Clement Park (July 13, 2014)",
        url: "http://www.songkick.com/concerts/19514814-searson-at-clement-park?utm_source=27408&utm_medium=partner",
        date_month: "JUL",
        date_day: 13,
        date_year: 2014,
        id: 19514814
      }
      expect(concerts.length).to eq 37
      expect(concerts.first).to eq expected_concert
    end
  end

  it 'gets the next page of events for a city' do
    VCR.use_cassette('paginated_concerts') do
      event_search = EventSearch.new
      concerts = event_search.paginated_concerts(6404, 2)
      expected_concert = {
        date: "2014-07-16T19:00:00-0600",
        date_day: 16,
        date_month: "JUL",
        date_year: 2014,
        tag_line: "Enomatic at The Living Room (July 16, 2014)",
        url: "http://www.songkick.com/concerts/21048853-enomatic-at-living-room?utm_source=27408&utm_medium=partner",
        id: 21048853
      }
      expect(concerts.length).to eq 45
      expect(concerts.first).to eq expected_concert
    end
  end
end