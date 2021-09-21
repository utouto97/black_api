module Api::V1
  class RoomsController < ApplicationController
    include FirebaseAuthConcern

    before_action :authenticate_user!

    def index
      render status: :ok, json: {
        status: :ok,
        rooms: Room.all#.select(:id, :name, :uid),
      }
    end

    def create
      uid = nil
      loop do
        uid = SecureRandom.alphanumeric(10)
        break if Room.find_by(uid: uid).nil?
      end

      param = params.require(:room).permit(:name, :password)
      password = param[:name] || ""
      require_password = param[:password].blank?

      room = Room.create({
        name: param[:name],
        password: password,
        require_password: !require_password,
        uid: uid
      })

      render status: :created, json: {
        status: :created,
        room: room
      }
    end

    def update
      room_id = params.require(:room_id)
      room = Room.find_by(uid: room_id)

      unless room
        render status: :not_found, json: {
          status: :not_found,
          msg: "The room with id=#{room_id} isn't found."
        } and return
      end

      room.update(params.require(:room).permit(:name, :password))

      render status: :created, json: {
        status: :created,
        room: room
      }
    end

    def destroy
      room_id = params.require(:room_id)
      room = Room.find_by(uid: room_id)

      unless room
        render status: :not_found, json: {
          status: :not_found,
          msg: "The room with id=#{room_id} isn't found."
        } and return
      end

      render status: :created, json: {
        status: :created,
        msg: "The room was deleted successfully."
      }
    end

  end
end
