module Api::V1
  class RoomUsersController < ApplicationController
    include CurrentUserConcern
    before_action :set_user

    def set_user
      @user = current_user
    end

    def rooms
      render json: { status: :success, rooms: @user.rooms }
    end

    def join
      room_id = params[:room_id]
      password = params[:password]
      room = Room.find_by(uid: room_id)
      if room.password_digest and not room.authenticate(password)
        render json: { status: :unauthorize } and return
      end
      @user.join(room_id)
      render json: { status: :success, room: @user.rooms}
    end

    def leave
      room_id = params[:room_id]
      @user.leave(room_id)
      render json: { status: :success, room: @user.rooms }
    end
  end
end
