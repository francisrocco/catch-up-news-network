App.comments = App.cable.subscriptions.create('CommentsChannel', {  
  received: function(data) {

    return $('#comments').prepend(this.renderComment(data));

  },

  renderComment: function(data) {
  	$('textarea').val('');
  	return "<p> <span class='comment'> <strong>" + "<a href='users/" + data.user_id + "'>" + data.user + "</a> " + data.datetime + ": </strong>" + data.comment + "</span></p>"
  	

  }
});