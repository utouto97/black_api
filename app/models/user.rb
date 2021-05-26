class User < ApplicationRecord
  has_many :relationships
  has_many :others, through: :relationships, source: :other

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(other_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(other_id: other_user.id)
    relationship.destroy if relationship
  end

  has_many :room_users
  has_many :rooms, through: :room_users

  def join(room_id)
    room_user = self.room_users.find_or_create_by(room_id: room_id)
  end

  def leave(room_id)
    room_user = self.room_users.find_by(room_id: room_id)
    room_user.destroy if room_user
  end
end
