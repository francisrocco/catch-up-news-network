class Post < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags

  def preview
    Onebox.preview(self.link).to_s
  end

end
