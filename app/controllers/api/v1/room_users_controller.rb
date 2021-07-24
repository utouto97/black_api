module Api::V1
  class RoomUsersController < ApplicationController
    include CurrentUserConcern

    def rooms
      render json: { status: :success, rooms: current_user.rooms.map{|r| {
        uid: r.uid,
        name: r.name
      }}}
    end

    def join
      room_id = params[:room_id]
      password = params[:password]
      room = Room.find_by(uid: room_id)
      if room.password_digest and not room.authenticate(password)
        render json: { status: :unauthorize } and return
      end
      current_user.join(room_id)
      render json: { status: :success, room: current_user.rooms}
    end

    def leave
      room_id = params[:room_id]
      current_user.leave(room_id)
      render json: { status: :success, room: current_user.rooms }
    end
  end
end
