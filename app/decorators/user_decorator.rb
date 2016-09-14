class UserDecorator < SimpleDelegator

	def display_user_relationship
		if current_user.friends_with?(user)
			return "You're both friends!"
		end

		




# <% if current_user.following?(@user) %>

# 	<% if current_user.followed_by?(@user) %>
# 		<p>You're both friends!</p>
# 	<% else %>
# 		<p>You're following <%= @user.name %>!</p>
# 	<% end %>

# 	<% else %>
# 		<%= link_to "Follow #{@user.name}!", follow_path(@user), method: 'post','data-type' => 'json', :remote => true, :class => "new_follow_link", :id => "#{@user.id}-follow" if @user != current_user %>
# 		<% if @user.following?(current_user) %>
# 			<p><%= @user.name %> is following you!</p>
# 		<% end %>
# <% end %>



	end

end