class Post < ApplicationRecord
  belongs_to :user

  def thumbnail
    object = LinkThumbnailer.generate(self.link)
  end

  def post_title
    title = self.thumbnail.title
    if title.length < 40
      return title
    else
      return title[0..37] + "..."
    end
  end

  def description
    desc = self.thumbnail.description
    if desc.length < 100
      return desc
    else
      return desc[0..97] + "..."
    end
  end

  def favicon
    self.thumbnail.favicon
  end

  def image
    self.thumbnail.images.first.src.to_s
  end

end
