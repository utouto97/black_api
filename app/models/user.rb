class User < ApplicationRecord
  has_many :room_users
  has_many :rooms, through: :room_users

  def join(room_id)
    room = Room.find_by(uid: room_id)
    room_user = self.room_users.find_or_create_by(room_id: room.id)
  end

  def leave(room_id)
    room = Room.find_by(uid: room_id)
    room_user = self.room_users.find_by(room_id: room.id)
    room_user.destroy if room_user
  end

  def member?(room_id)
    room = Room.find_by(uid: room_id)
    return self.room_users.find_by(room_id: room.id, user_id: self.id) != nil
  end
end
