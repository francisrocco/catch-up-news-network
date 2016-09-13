App.comments = App.cable.subscriptions.create('CommentsChannel', {  
  received: function(data) {
  	debugger;
    return $('#comments').append(this.renderComment(data));
  	debugger;
  },

  renderComment: function(data) {
  	return "<p> <span class='comment'> <strong>" + "<a href='users/" + data.user_id + "'>" + data.user + "</a> " + data.datetime + ": </strong>" + data.comment + "</span></p>";
  }
});