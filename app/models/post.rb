class Post < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags

# USING ONEBOX

  def preview
    Onebox.preview(self.link).to_s
  end

# USING THUMBNAILER

  def thumbnail
    object = LinkThumbnailer.generate(self.link)
  end

  def post_title
    self.thumbnail.title
  end

  def description
    desc = self.thumbnail.description
    if desc.length < 140
      return desc
    else
      return desc[0..135] + "..."
    end
  end

  def favicon
    self.thumbnail.favicon
  end

  def image
    self.thumbnail.images.first.src.to_s
  end

end
