module UsersHelper

	def display_user_relationship(user, current_user)
		if current_user.friends_with?(user)
			return "You're both friends!"
		end

		if current_user.following?(user)
			return "You're following #{user.name}!"
		elsif current_user.followed_by?(user)
			return "#{user.name} is following you!"
		end
	end

	def display_follow_link(user, current_user)
		if current_user != user && !current_user.following?(user)
			yield
		end
	end

	def display_user_followers(user)
		if user.has_followers?

			case user.followers_count
			when 1
				statement = "One person is following #{user.name}:"
			else
				statement = "#{user.followers_count} people are following #{user.name}:"
			end

			return statement

		else
			return "#{user.name} has no followers. 😞"
		end

	end

	def display_user_following(user)
		if user.has_following?

			case user.following_count
			when 1
				return "#{user.name} is following one person:"
			else
				return "#{user.name} is following #{user.following_count} people:"
			end

		else
			return "#{user.name} isn't following anyone. 😞"
		end
	end

end
