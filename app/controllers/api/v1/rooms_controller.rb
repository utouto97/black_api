module Api::V1
  class RoomsController < ApplicationController
    include CurrentUserConcern
    before_action :set_user

    def set_user
      @user = current_user
    end

    def index
      rooms = Room.all
      render json: { status: :success, rooms: rooms }
    end

    def create
      name = params[:roomname]
      password = params[:password]
      room = Room.create(
        name: name,
        password: password,
      )
      render json: { status: :success, room: room }
    end

    def join
      room_id = params[:room_id]
      @user.join(room_id)
      render json: { status: :success, room: @user.rooms}
    end

    def leave
      room_id = params[:room_id]
      @user.leave(room_id)
      render json: { status: :success, room: @user.rooms}
    end

  end
end
