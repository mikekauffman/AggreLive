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

  scenario 'User can unfavorite shows' do
    user = create_user(email: 'joe4@example.com')
    create_event(tag_line: 'This event will be removed', user_id: user.id)
    create_event(tag_line: 'This event will not be removed', user_id: user.id)
    visit root_path
    click_on 'Login'
    fill_in 'user[email]', with: 'joe4@example.com'
    fill_in 'user[password]', with: 'password'
    click_on 'Sign In'
    click_on 'My Account'
    expect(page).to have_content "This event will be removed"
    expect(page).to have_content "This event will not be removed"
    within page.first(:css, ".social") do
      find('a').click
    end
    expect(page).to_not have_content "This event will be removed"
    expect(page).to have_content "This event will not be removed"
  end
end