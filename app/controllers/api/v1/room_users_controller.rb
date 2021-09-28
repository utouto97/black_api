module Api::V1
  class RoomUsersController < ApplicationController
    include FirebaseAuthConcern

    def index
      render status: :ok, json: {
        status: :ok,
        user_id: current_user.id,
        rooms: current_user.rooms.select(:id, :uid, :name)
      }
    end

    def create
      room_id = params.require(:room_id)
      room = Room.find_by(uid: room_id)

      if not room
        render status: :not_found, json: {
          status: :not_found,
          msg: "The room with id=#{room_id} isn't found."
        } and return
      end

      if room.require_password and not room.authenticate(params[:password])
        render status: :unauthorized, json: {
          status: :unauthorized,
          msg: "Password is not correct.",
          pw: params[:password]
        } and return
      end

      current_user.join(room_id)

      render status: :created, json: {
        status: :created,
        user_id: current_user.id,
        room_id: room_id
      }
    end

    def destroy
      room_id = params.require(:room_id)
      room = Room.find_by(uid: room_id)

      if not room
        render status: :not_found, json: {
          status: :not_found,
          msg: "The room with id=#{room_id} isn't found."
        } and return
      end

      current_user.leave(room_id)

      render status: :ok, json: {
        status: :ok,
        user_id: current_user.id,
        room_id: room_id
      }
    end

  end
end
