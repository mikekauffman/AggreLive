require 'spec_helper'

describe Event do
  it 'events can be created and reference a user' do
    user = create_user(email: 'joe2@example.com')
    event = create_event(user_id: user.id)
    expect(user.events.last.id).to eq(event.id)
  end

  it 'can take a datetime string and extract a day, month, and year' do
    user = create_user(email: 'joe3@example.com')
    event = create_event(user_id: user.id)
    expect(event.date_day).to eq('14')
    expect(event.date_month).to eq('JUL')
    expect(event.date_year).to eq('2014')
  end
end
