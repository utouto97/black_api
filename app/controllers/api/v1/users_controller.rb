module Api::V1
  class UsersController < ApplicationController
    include FirebaseAuthConcern
    include CurrentUserConcern

    def index
      users = User.all
      render json: { users: users }
    end

    def create
      auth = authenticate_token_by_firebase
      render json: { status: :unauthorized } and return unless auth[:data]

      username = params[:username]
      render json: { status: :bad_request } and return unless username

      uid = auth[:data][:uid]
      email = auth[:data][:decoded_token][:payload]["email"]

      user = User.find_or_create_by(firebase_uid: uid) do |user|
        user.firebase_uid = uid
        user.email = email
        user.username = username
      end

      render json: { message: 'created user successfully', user: user }
    end

    def destroy
      current_user.destroy
      render json: { message: 'deleted user', user: current_user }
    end
  end
end
