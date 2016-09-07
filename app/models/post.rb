class Post < ApplicationRecord
  belongs_to :user

  def preview
    Onebox.preview(self.link).to_s
  end

end
