module Api::V1
  class HelloController < ApplicationController
    include CurrentUserConcern

    def index
      user = current_user
      render json: {
        message: 'hello',
        user: user,
        others: user.others,
        rooms: user.rooms,
      }
    end
  end
end
