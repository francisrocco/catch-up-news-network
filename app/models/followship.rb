class Followship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"

  validates_uniqueness_of :follower_id, :scope => :following_id

  validate :cannot_follow_self

  def cannot_follow_self
  	unless follower_id != following_id
  		errors.add(:followship, "Oh dear me, you can't follow yourself, silly!")
  	end
  end

end
