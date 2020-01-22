class Relationship < ApplicationRecord
  belongs_to :follower, class: 'User'
  belongs_to :followed, class: 'User'
  validates :followed_id, presence: true
  validates :follower_id, presence: true
end
