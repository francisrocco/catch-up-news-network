module UsersHelper

	def display_user_relationship(user, current_user)
		if current_user.friends_with?(user)
			return "You're both friends!"
		end

		if current_user.following?(user)
			return "You're following #{user}!"
		elsif current_user.followed_by?(user)
			return "#{user} is following you!"
		end
	end

	def display_follow_link(user, current_user)
		if current_user != user && !current_user.following?(user)
			yield
		end
	end

end
