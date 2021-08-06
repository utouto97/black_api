module Api::V1
  class MessagesController < ApplicationController
    include CurrentUserConcern

    def index
      room_id = params['room_id']
      lim = params['lim'] || 20
      after = params['after']
      before = params['before']

      render json: { status: :bad_request } and return unless room_id
      render json: { status: :unauthorized } and return unless current_user
      render json: { status: :unauthorized } and return unless current_user.member?(room_id)

      messages = Message.joins(:room)
        .where(room: { uid: room_id })
      messages = messages.where.not(created_at: ..Time.zone.parse(after)) if after.present?
      messages = messages.where(created_at: ...Time.zone.parse(before)) if before.present?
      messages = messages.order(created_at: :desc).limit(lim)
      messages = messages.joins(:user).select("messages.*, users.id as user_id, users.username")
      render json: { status: :success, messages: messages }
    end

    def create
      room_id = params['room_id']
      content = params['content']

      render json: { status: :bad_request } and return unless room_id
      render json: { status: :unauthorized } and return unless current_user
      render json: { status: :unauthorized } and return unless current_user.member?(room_id)

      room = Room.find_by(uid: room_id)
      message = Message.create(
        user_id: @user.id,
        room_id: room.id,
        content: content
      )
      render json: { status: :success, messages: message }
    end

  end
end
