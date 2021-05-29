class Room < ApplicationRecord
  has_secure_password

  has_many :room_users
  has_many :users, through: :room_users
end
