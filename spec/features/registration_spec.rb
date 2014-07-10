require 'spec_helper'

feature 'User registers to the site' do
  scenario 'User can register a new account' do
    visit root_path
    click_on 'Register'
    fill_in 'user[first_name]', with: 'Joe'
    fill_in 'user[last_name]', with: 'Buck'
    fill_in 'user[email]', with: 'joe@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_on 'Sign Up'
    expect(page).to have_content 'Welcome, Joe'
    expect(page).to have_content 'Logout'
  end
  scenario 'User cannot register with empty name fields' do
    visit root_path
    click_on 'Register'
    fill_in 'user[first_name]', with: ''
    fill_in 'user[last_name]', with: ''
    fill_in 'user[email]', with: 'joe@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_on 'Sign Up'
    expect(page).to have_content "First name can't be blank"
    expect(page).to have_content "Last name can't be blank"
  end
  scenario 'User cannot register with an empty email field' do
    visit root_path
    click_on 'Register'
    fill_in 'user[first_name]', with: 'Joe'
    fill_in 'user[last_name]', with: 'Buck'
    fill_in 'user[email]', with: ''
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_on 'Sign Up'
    expect(page).to have_content "Email can't be blank"
  end
  scenario 'User cannot register with an empty password field' do
    visit root_path
    click_on 'Register'
    fill_in 'user[first_name]', with: 'Joe'
    fill_in 'user[last_name]', with: 'Buck'
    fill_in 'user[email]', with: 'joe@example.com'
    fill_in 'user[password]', with: ''
    fill_in 'user[password_confirmation]', with: ''
    click_on 'Sign Up'
    expect(page).to have_content "Password can't be blank"
  end
  scenario 'User cannot register if passwords do not match' do
    visit root_path
    click_on 'Register'
    fill_in 'user[first_name]', with: 'Joe'
    fill_in 'user[last_name]', with: 'Buck'
    fill_in 'user[email]', with: 'joe@example.com'
    fill_in 'user[password]', with: 'password111'
    fill_in 'user[password_confirmation]', with: 'password222'
    click_on 'Sign Up'
    expect(page).to have_content "Password confirmation doesn't match"
  end
end