def create_user(attributes = {})
  defaults = {
    first_name: 'Joe',
    last_name: 'Buck',
    email: 'joe@example.com',
    password: 'password'
  }
  User.create!(defaults.merge(attributes))
end

def create_event(attributes = {})
  defaults = {
    event_id: 19834959,
    date: "2014-07-14T20:00:00-0600",
    tag_line: "Mac DeMarco with Calvin Love and The Meatbodies at",
    url: "http://www.songkick.com/concerts/19834959",
    artist: "Mac DeMarco",
    user_id: nil,
  }
  Event.create!(defaults.merge(attributes))
end
