require 'spec_helper'

feature 'User searches for upcoming shows' do
  scenario 'Non logged in user enters a city in the search bar' do
    visit root_path
    fill_in 'search_term', with: 'Denver, CO'
    click_on 'Submit'
    expect(page).to have_content 'Upcoming shows near Denver, CO'
  end
end