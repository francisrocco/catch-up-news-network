class User < ApplicationRecord
	has_many :votes, dependent: :destroy
	has_many :posts
  has_many :comments
	has_secure_password

	has_many :followerships, foreign_key: 'follower_id', class_name: 'Followship'
	has_many :followingships, foreign_key: 'following_id', class_name: 'Followship'

	# Validations
	# ============
	validates :name, uniqueness: true, presence: true, length: { minimum: 3, maximum: 25 }
	validates :email, {
		uniqueness: true,
		presence: true,
		format: {
			with:
			/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
			on: :create
		}
	}

	# Methods
	# =========

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
	# later, we need another method that returns followings and followers who are NOT friends with self	
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
	 self.followers_count > 0
	end

	# is self following anyone?
	def has_following?
	 self.following_count > 0
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

	def has_friends?
		self.has_following? && self.has_followers?
	end

	def friends
		# this works! but can someone refactor it using AR assocations so that
		# it returns an AR_Relation instead of an Array?
		if self.has_friends?
			user_following = self.following.collect {|f| f.name}
			self.followers.select {|follower| user_following.include?(follower.name)}
		else
			return nil
		end
	end

	def friends_with?(user)
		if has_friends?
			if self.following?(user) && self.followed_by?(user)
				return true 
			else
				return false
			end
		else
			# we need this because it otherwise returns 'nil' and 'nil' isn't falsey enough!
			return false
		end
	end

	# GETTING USER POSTS
	# ====================

  def get_user_posts
    Post.joins(:user).where(users: {id: self.id})
  end

  # returns an array of AR Associations
  def get_current_user_posts_by_following
		current_user.following.collect do |followed|
			followed.get_user_posts
		end
  end

  private

  	# only admin need this method
	  def get_user_posts_by_following
		self.following.collect do |followed|
			followed.get_user_posts
		end
  end

end
