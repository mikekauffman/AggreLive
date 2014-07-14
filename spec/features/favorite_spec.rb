require 'spec_helper'

feature 'User favorites a concert' do
  scenario 'User searches for upcoming shows and favorites the ones they like' do
    user = create_user(email: 'joe1@example.com')
    VCR.use_cassette('favorite_test') do
      visit root_path
      click_on 'Login'
      fill_in 'user[email]', with: 'joe1@example.com'
      fill_in 'user[password]', with: 'password'
      click_on 'Sign In'
      fill_in 'search_term', with: 'Denver, CO'
      click_on 'Submit'
      within page.first(:css, ".social") do
        find('a').click
      end
      expect(page).to have_content "Joe Buck's Favorited Shows"
      expect(page).to have_content "Mac DeMarco with Calvin Love and The Meatbodies at Bluebird Theater"
    end
  end
end