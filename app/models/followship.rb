class Followship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"
  validates :follower_id, uniqueness: true
  validates :following_id, uniqueness: true
end
