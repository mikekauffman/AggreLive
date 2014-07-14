class User < ActiveRecord::Base
  has_many :events
  has_secure_password
  has_many :searches
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

end
