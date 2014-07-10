require 'spec_helper'

describe Search do
  it 'can create a search' do
    search = Search.new(
      term: "Denver CO"
    )
    expect(search).to be_valid
  end
  it 'can edit the user input to be url_safe' do
    search = Search.new(
      term: "Denver, CO"
    )
    expect(search.url_safe_term).to eq 'Denver+CO'
  end
  it 'can be associated with a user' do
    user = User.create!(
      first_name: "Joe",
      last_name: "buck",
      email: "joe@example.com",
      password: "password",
      password_confirmation: "password"
    )
    search = Search.create!(
      term: "Denver CO",
      user_id: user.id
    )
    expect(search.user).to eq(user)
  end
end
