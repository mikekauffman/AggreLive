require 'spec_helper'

describe User do
  it 'can create a user' do
    user = User.new(
      first_name: "Joe",
      last_name: "buck",
      email: "joe@example.com",
      password: "password",
      password_confirmation: "password"
    )
    expect(user).to be_valid
  end
  it 'will not create a user with empty attributes' do
    user = User.new(
      first_name: "",
      last_name: "",
      email: "",
      password: "",
      password_confirmation: ""
    )
    expect(user).to_not be_valid
  end
end