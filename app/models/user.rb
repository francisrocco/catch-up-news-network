class User < ApplicationRecord
	has_many :votes, dependent: :destroy
	has_many :posts
  has_many :comments
	has_secure_password

	has_many :followerships, foreign_key: 'follower_id', class_name: 'Followship'
	has_many :followingships, foreign_key: 'following_id', class_name: 'Followship'

	# self follows a new user
  def follow(user)
    new_relationship = Followship.new(following_id: user.id, follower_id: self.id)
    if new_relationship.save
      return true
    else
      return false
    end
  end

	# return everyone following self
  def followers
  	# this returns an array, which is a bit inconvenient
  	# self.class.find_by_sql(['SELECT * FROM users JOIN followships ON users.id = followships.following_id WHERE followships.following_id = ?', self.id])

  	# but this returns an activerecord relation!
  	self.class.joins(:followerships).where(followships: {following_id: self.id})
  end

	# return everyone that self is following
  def following
    self.class.joins(:followingships).where(followships: {follower_id: self.id})
  end

  def followers_count
  	followers.count
  end

  def following_count
  	following.count 
  end

	# is anyone following self?
	def has_followers?
	 self.followers.size > 0
	end

	# is self following anyone?
	def has_following?
	 self.following.size > 0
	end

	# self.following?(user) => is self following user?
	def following?(user)
		if self.has_following?
			if self.following.where(name: user.name).exists?
				return true
			else
				# we need this because it otherwise returns 'nil' and 'nil' isn't falsey enough!
				return false
			end
		else
			return false
		end
	end

	# self.followed_by?(user) => is self followed by user?
	def followed_by?(user)
		if self.has_following?
			if self.followers.where(name: user.name).exists?
				return true
			else
				# we need this because it otherwise returns 'nil' and 'nil' isn't falsey enough!
				return false
			end
		else
			return false
		end
	end

	def friends?(user)
		if self.following?(user) && self.followed_by?(user)
			return true 
		else
			return false
		end
	end

end
