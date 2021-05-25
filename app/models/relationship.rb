class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :other, class_name: 'User'

  validates :user_id, presence: true
  validates :other_id, presence: true
end
