module Api::V1
  class HelloController < ApplicationController
    include FirebaseAuthConcern
    before_action :set_auth, only: %i[index]

    def set_auth
      @auth = authenticate_token_by_firebase
    end

    def index
      render json: { message: 'hello', user: @auth }
    end
  end
end
