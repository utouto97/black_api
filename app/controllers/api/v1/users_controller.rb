module Api::V1
  class UsersController < ApplicationController
    include FirebaseAuthConcern

    before_action :authenticate_user!

    def index
    end

    def create
    end

    def update
    end

    def destroy
    end
  end
end
