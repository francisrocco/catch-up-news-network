class Tag < ApplicationRecord
  has_and_belongs_to_many :posts

  def all_posts
    Post.joins(:tags).where(tags: {id: self.id})
  end

end
