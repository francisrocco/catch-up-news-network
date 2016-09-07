class User < ApplicationRecord
	has_many :friendsips
	has_many :friends, through: :friendships
	has_many :votes
	has_many :posts
	has_secure_password

end
