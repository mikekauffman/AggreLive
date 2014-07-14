require 'spec_helper'

describe CitySearch do
  it 'can find a city id from a search term' do
    VCR.use_cassette('city_search') do
      city_search = CitySearch.new
      city_id = city_search.id_for('Denver, Co')
      expect(city_id).to eq(6404)
    end
  end

  it 'raise a CityNotFoundError if the city can not be found' do
    VCR.use_cassette('no_city_found') do
      city_search = CitySearch.new
      expect{city_search.id_for('Malibucktoo, Co')}.to raise_error(CitySearch::CityNotFoundError)
    end
  end
end