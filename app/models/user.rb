class User < ApplicationRecord
  has_many :followships, foreign_key: 'follower_id'
  # has_many :followers, through: :followships, foreign_key: 'follower_id'
  # has_many :followings, through: :followships, foreign_key: 'following_id'
	has_many :votes, dependent: :destroy
	has_many :posts
    has_many :comments
	has_secure_password

	def followers
		self.followships.collect { |follower| follower  }
	end

	def following
		self.followships.collect { |following| following  }
	end

end
