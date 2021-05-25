module Api::V1
  class UsersController < ApplicationController
    include FirebaseAuthConcern
    include CurrentUserConcern
    before_action :set_user, only: %i[index]

    def set_user
      @user = current_user
    end

    def index
      users = User.all
      render json: { users: users }
    end

    def create
      auth = authenticate_token_by_firebase
      render json: { status: :unauthorized } and return unless auth[:data]

      uid = auth[:data][:uid]
      user = User.find_by(firebase_uid: uid)
      render json: { message: 'user already exist'} and return unless user.blank?

      username = params[:username]
      render json: { message: 'username is required'} and return unless username

      email = auth[:data][:decoded_token][:payload]["email"]
      pp email
      user = User.new(
        firebase_uid: uid,
        email: email,
        username: username
      )
      user.save

      render json: { message: 'created user successfully', user: user }
    end
  end
end
