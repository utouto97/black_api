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
        uid: SecureRandom.alphanumeric(10),
      )
      render json: { status: :success, room: room }
    end

  end
end
