class User < ApplicationRecord
  has_many :followships
  has_many :followers, through: :followships, foreign_key: 'follower_id'
  has_many :followings, through: :followships, foreign_key: 'following_id' 
	has_many :votes
	has_many :posts
  has_many :comments
	has_secure_password

end
