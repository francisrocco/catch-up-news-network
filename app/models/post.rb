class Post < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :comments

  def thumbnail
    object = LinkThumbnailer.generate(self.link)
  end

  def post_title
    return self.title unless title = self.thumbnail.title
    if title.length < 35
      return title
    else
      return title[0..33] + "..."
    end
  end

  def description
    desc = self.thumbnail.description
    desc = self.title if self.thumbnail.images.first.src.to_s[-3..-1] != "jpg"
    if desc.length < 120
      return desc
    else
      return desc[0..117] + "..."
    end
  end

  def favicon
    self.thumbnail.favicon
  end

  def image
    img = self.thumbnail.images.first.src.to_s
    if img[-3..-1] != "jpg"
      return "http://img00.deviantart.net/4854/i/2013/352/8/1/newspaper_collage_texture_by_flordeneu-d6yeuvs.jpg"
    else
      return img
    end
  end

end
