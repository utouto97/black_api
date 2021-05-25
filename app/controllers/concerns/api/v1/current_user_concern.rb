module Api::V1
  module CurrentUserConcern
    extend ActiveSupport::Concern
    include FirebaseAuthConcern

    def current_user
      auth = authenticate_token_by_firebase
      return nil unless auth[:data]

      uid = auth[:data][:uid]
      user = User.find_by(firebase_uid: uid)

      return user
    end
  end
end
