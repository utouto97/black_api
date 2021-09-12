module Api::V1
  class UsersController < ApplicationController
    include FirebaseAuthConcern

    before_action :authenticate_user!

    def index
      render status: :ok, json: {
        status: :ok,
        user: current_user
      }
    end

    def create
      render status: :ok, json: {
        status: :ok,
        msg: "The user already exists.",
      } and return if current_user

      info = get_firebase_info
      user = User.create({
        firebase_uid: info[:uid],
        email: nil,
        **params.require(:user).permit(:username)
      })

      render status: :created, json: {
        status: :created,
        user: user
      }
    end

    def update
      current_user.update({
        **params.require(:user).permit(:username)
      })

      render status: :created, json: {
        status: :created,
        user: current_user
      }
    end
  end
end
