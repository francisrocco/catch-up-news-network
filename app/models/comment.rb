class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def is_new_comment?
    seconds = Time.now - self.created_at
    seconds < 300 ? true : false
  end

  def datetime
    if is_new_comment?
      "just now"
    else
      self.created_at.strftime('on %a, %D at %l:%M %P')
    end
  end

  def author
  	self.post.user.name
  end

  # not using this, but maybe it'll become useful?
  def parse_comment
  	"#{author} on #{datetime}: #{self.message}"
  end


end
