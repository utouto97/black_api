module Api::V1
  class RelationshipsController < ApplicationController
    include CurrentUserConcern
    before_action :set_user

    def set_user
      @user = current_user
    end

    def followings
      followings = @user.others
      render json: { status: :success, followings: followings }
    end

    def follow
      other_id = params[:other_id]
      other = User.find_by(id: other_id)
      following = @user.follow(other)
      if following.save
        render json: { status: :success, message: 'followed successfully'}
      else
        render json: { status: :bad_request, message: 'couldn\'t follow' }
      end
    end

    def unfollow
      other_id = params[:other_id]
      other = User.find_by(id: other_id)
      following = @user.unfollow(other)
      if following.destroy
        render json: { status: :success, message: 'unfollowed successfully'}
      else
        render json: { status: :bad_request, message: 'couldn\'t unfollow' }
      end
    end
  end
end
