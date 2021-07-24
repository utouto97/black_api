module Api::V1
  class RoomsController < ApplicationController
    include CurrentUserConcern

    def index
      rooms = Room.all.map{|r| {
        uid: r.uid, name: r.name
      }}
      render json: { status: :success, rooms: rooms }
    end

    def info
      room = Room.find_by(uid: params.require(:id))
      render json: { status: :success, room: {
        uid: room.uid,
        name: room.name
      }}
    end

    def create
      name = params[:roomname]
      password = params[:password]
      room = Room.create(
        name: name,
        password: password,
        uid: SecureRandom.alphanumeric(10),
      )
      render json: { status: :success, room: room }
    end

  end
end
