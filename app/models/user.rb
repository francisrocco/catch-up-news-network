class User < ApplicationRecord
	has_many :votes, dependent: :destroy
	has_many :posts
  has_many :comments
	has_secure_password

	# current user follows a new user: current_user.follow(user) => current user is now following user
  def follow(user)
    new_relationship = Followship.new(following_id: user.id, follower_id: self.id)
    if new_relationship.save
      return true
    else
      return false
    end
  end

	# return everyone following the user
  def followers
  	self.class.find_by_sql(['SELECT * FROM users JOIN followships ON users.id = followships.following_id WHERE followships.following_id = ?', self.id])
  end

	# return everyone that a user is following
  def following
    self.class.find_by_sql(["SELECT * FROM users JOIN followships ON users.id = followships.following_id WHERE followships.follower_id = ?", self.id])
  end

	# self.following?(user) => is self following user?
	def following?(user)
		if self.following.where(name: user.name).size < 0
			return true
		else
			return false
		end
	end

	# self.followed_by?(user) => is self followed by user?
	def followed_by?(user)
		if self.followers.where(name: user.name).size < 0
			return true
		else
			return false
		end
	end

	# is anyone following self?
	def has_followers?
	 self.followers.size > 0
	end

	# is self following anyone?
	def has_following?
	 self.following.size > 0
	end

	def friends?(user)
		if self.following?(user) && self.followed_by?(user)
			return true 
		else
			return false
		end
	end

end
