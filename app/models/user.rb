class User < ApplicationRecord
  # has_many :followships
  def followers
    Followship.where(following_id: self.id)
  end

  def following
    Followship.where(follower_id: self.id)
  end
  # has_many :followships
  has_many :followers, class_name: 'Followships'
  has_many :following, class_name: 'Followships'
	has_many :votes, dependent: :destroy
	has_many :posts
    has_many :comments
	has_secure_password

	# current user follows a new user: current_user.follow(user) => current user is now following user
  def follow(user)
    new_relationship = Followship.new(follower_id: self.id, following_id: user.id)
    if new_relationship.save
      return true
    else
      return false
    end
  end

  # think of 'following' as 'followee' and it makes sense to Tamtam

	# def followers
	# 	self.class.joins(:followships).where(followships: {following_id: self.id})
	# end

	# # return everyone that a user is following
	# def following
	# 	self.class.joins(:followships).where(followships: {follower_id: self.id})
	# end

	# self.following?(user) => is self following user?
	# def following?(user)
	# 	return true ? following : false
	# end

	# # self.followed_by?(user) => is self followed by user?
	# def followed_by?(user)
	# 	return true ? followers : false
	# end

	# def has_followers?
	#  self.followers.size > 0
	# end

	# def has_following?
	#  self.following.size > 0
	# end

	# def friends?(user)
	# 	if self.following?(user) && self.followed_by?(user)
	# 		return true 
	# 	else
	# 		return false
	# 	end
	# end


end