class UserDecorator < SimpleDelegator


	# make a user view helper
	# def display_user_relationship(user, current_user)
	# 	if current_user.friends_with?(user)
	# 		return "You're both friends!"
	# 	end

	# 	if current_user.following?(user)
	# 		return "You're following #{user}!"
	# 	elsif current_user.followed_by?(user)
	# 		return "#{user} is following you!"
	# 	end
	# end

# 	<% else %>
# 		<%= link_to "Follow #{@user.name}!", follow_path(@user), method: 'post','data-type' => 'json', :remote => true, :class => "new_follow_link", :id => "#{@user.id}-follow" if @user != current_user %>
# 		<% if @user.following?(current_user) %>
# 			<p><%= @user.name %> is following you!</p>
# 		<% end %>
# <% end %>




end