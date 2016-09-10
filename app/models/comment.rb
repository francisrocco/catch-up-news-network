class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def is_new_comment?
    seconds = Time.now - self.created_at
    seconds < 300 ? true : false
  end

  def get_datetime
    if is_new_comment?
      "Just now:"
    else
      self.created_at.strftime('%l:%M %P, on %a, %D:')
    end
  end


end
