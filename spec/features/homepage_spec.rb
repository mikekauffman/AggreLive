require 'spec_helper'

feature 'User interacts with the homepage' do
  scenario 'Logo displays on hompeage' do
    visit root_path
    expect(page).to have_css("img", :exact => "/public/AggreLive_logo (2).png")
  end
end