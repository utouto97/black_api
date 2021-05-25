class User < ApplicationRecord
  has_many :relationships
  has_many :others, through: :relationships, source: :other

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(other_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(other_id: other_user.id)
    relationship.destroy if relationship
  end
end
