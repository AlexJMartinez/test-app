class User < ActiveRecord::Base
  has_secure_password
  validates :email, uniqueness: true
  validates :user_name, uniqueness: true
  has_many :photos
end
