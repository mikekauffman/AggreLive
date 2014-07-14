require 'spec_helper'

feature 'User searches for upcoming shows' do
  scenario 'user can search for upcoming concerts and see details of the shows' do
    VCR.use_cassette('concert_info_test') do
      visit root_path
      fill_in 'search_term', with: 'Denver, CO'
      click_on 'Submit'
      expect(page).to have_content 'Mac DeMarco with Calvin Love'
      expect(page).to have_content 'Bluebird Theater'
      expect(page).to have_content 'JUL'
      expect(page).to have_content '14'
    end
  end

  scenario 'user can search for upcoming concerts and see details of the shows' do
    VCR.use_cassette('feature_paginated_concerts') do
      visit root_path
      fill_in 'search_term', with: 'Denver, CO'
      click_on 'Submit'
      click_on '2'
      expect(page).to have_content 'Enomatic'
      expect(page).to have_content 'The Living Room'
      expect(page).to have_content 'JUL'
      expect(page).to have_content '16'
    end
  end
end