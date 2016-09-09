class Post < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :comments
  accepts_nested_attributes_for :tags, reject_if: lambda {|attributes| attributes['name'].blank?}
  has_many :votes, dependent: :destroy

  def thumbnail
    @object = LinkThumbnailer.generate(self.link)
  end

  def post_title
    return self.title unless title = @object.title
    if title.length < 35
      return title
    else
      return title[0..33] + "..."
    end
  end

  def description
    desc = @object.description
    desc = self.title if @object.images.first.src.to_s[-3..-1] != "jpg"
    if desc.length < 120
      return desc
    else
      return desc[0..117] + "..."
    end
  end

  def favicon
    @object.favicon
  end

  def image
    @object = LinkThumbnailer.generate(self.link)
    img = @object.images.first.src.to_s
    if img[-3..-1] != "jpg"
      return "http://img00.deviantart.net/4854/i/2013/352/8/1/newspaper_collage_texture_by_flordeneu-d6yeuvs.jpg"
    else
      return img
    end
  end

  #Methods for Votes function

  def up_votes
    self.votes.where(value: 1).count
  end

  def down_votes
    self.votes.where(value: -1).count
  end

  def total_votes
    self.up_votes - self.down_votes
  end



end
