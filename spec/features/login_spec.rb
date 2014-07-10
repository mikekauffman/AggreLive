require 'spec_helper'

feature 'Users login to the site' do

  before do
    visit root_path
    click_on 'Register'
    fill_in 'user[first_name]', with: 'Joe'
    fill_in 'user[last_name]', with: 'Buck'
    fill_in 'user[email]', with: 'joe@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_on 'Sign Up'
    expect(page).to have_content 'Welcome, Joe'
    click_on 'Logout'
    expect(page).to have_content 'Login'
  end

  scenario 'Registered users can login with valid information' do
    visit root_path
    click_on 'Login'
    fill_in 'user[email]', with: 'joe@example.com'
    fill_in 'user[password]', with: 'password'
    click_on 'Sign In'
    expect(page).to have_content 'Welcome, Joe'
  end

  scenario 'User cannot login with the wrong email' do
    visit root_path
    click_on 'Login'
    fill_in 'user[email]', with: 'joebuckisme@example.com'
    fill_in 'user[password]', with: 'password'
    click_on 'Sign In'
    expect(page).to have_content 'Invalid email or password'
  end

  scenario 'User cannot login with the wrong password' do
    visit root_path
    click_on 'Login'
    fill_in 'user[email]', with: 'joe@example.com'
    fill_in 'user[password]', with: 'password1234'
    click_on 'Sign In'
    expect(page).to have_content 'Invalid email or password'
  end

end