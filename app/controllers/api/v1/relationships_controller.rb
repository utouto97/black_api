module Api::V1
  class RelationshipsController < ApplicationController
    include CurrentUserConcern

    def followings
      followings = current_user.others
      render json: { status: :success, followings: followings }
    end

    def follow
      other_id = params[:other_id]
      other = User.find_by(id: other_id)
      following = current_user.follow(other)
      if following.save
        render json: { status: :success, message: 'followed successfully'}
      else
        render json: { status: :bad_request, message: 'couldn\'t follow' }
      end
    end

    def unfollow
      other_id = params[:other_id]
      other = User.find_by(id: other_id)
      following = current_user.unfollow(other)
      if following.destroy
        render json: { status: :success, message: 'unfollowed successfully'}
      else
        render json: { status: :bad_request, message: 'couldn\'t unfollow' }
      end
    end
  end
end
