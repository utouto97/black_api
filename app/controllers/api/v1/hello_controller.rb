module Api::V1
  class HelloController < ApplicationController
    include CurrentUserConcern
    before_action :set_user, only: %i[index]

    def set_user
      @user = current_user
    end

    def index
      render json: {
        message: 'hello',
        user: @user,
        others: @user.others,
        rooms: @user.rooms,
      }
    end
  end
end
