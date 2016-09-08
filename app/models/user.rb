class User < ApplicationRecord
  has_many :followships, foreign_key: 'follower_id'
	has_many :votes
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

	# return all of a user's followers (user.followers => [an array])
		def followers
		# getting Followship instances
		followships = Followship.where(following_id: self.id)
		# getting the User instances from the Followship instance
		followships.collect do |followship|
			followship.following
		end
	end

	# return everyone that a user is following
	def following
		followships = Followship.where(follower_id: self.id)
		followships.collect do |followship|
			followship.follower
		end
	end

	# self.following?(user)
	def following?(user)
		self.following.any? {|following| following.following_id == user.id}
	end

	# self.followed_by?(user)
	def followed_by?(user)
		self.followers.any? {|follower| follower.follower_id == user.id}
	end

	def friends?(user)
		if self.following?(user) && self.followed_by?(user)
			return true 
		else
			return false
		end
	end


end