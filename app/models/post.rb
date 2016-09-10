class Post < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :comments
  has_many :votes, dependent: :destroy
  accepts_nested_attributes_for :tags, reject_if: lambda {|attributes| attributes['name'].blank?}

  # def thumbnail
  #   @thumbnail ||= LinkThumbnailer.generate(self.link)
  # end

  # def post_title
  #   return self.title unless title = thumbnail.title
  #   if title.length < 35
  #     return title
  #   else
  #     return title[0..33] + "..."
  #   end
  # end

  # def description
  #   desc = thumbnail.description
  #   desc = self.title if thumbnail.images.first.src.to_s[-3..-1] != "jpg"
  #   if desc.length < 120
  #     return desc
  #   else
  #     return desc[0..117] + "..."
  #   end
  # end

  # def favicon
  #   thumbnail.favicon
  # end

  # def image
  #   thumbnail = LinkThumbnailer.generate(self.link)
  #   img = thumbnail.images.first.src.to_s
  #   if img[-3..-1] != "jpg"
  #     return "http://img00.deviantart.net/4854/i/2013/352/8/1/newspaper_collage_texture_by_flordeneu-d6yeuvs.jpg"
  #   else
  #     return img
  #   end
  # end


  #Methods for Votes function

  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def total_votes
    self.up_votes - self.down_votes
  end

  def self.most_popular
    Post.joins(:votes).group('posts.id').order('SUM(votes.value) DESC')
  end


end
