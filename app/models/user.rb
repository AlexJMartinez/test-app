class User < ActiveRecord::Base
  has_secure_password
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create
  validates :user_name, uniqueness: true  
  has_many :photos
end
