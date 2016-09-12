class Post < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :comments
  has_many :votes, dependent: :destroy
  # accepts_nested_attributes_for :tags, reject_if: lambda {|attributes| attributes['name'].blank?}
  def tags_attributes=(args = {})
    args.each do |num, tag| 
      self.tags << Tag.find_or_create_by(name: tag['name']) unless tag['name'] == ""
    end
  end

  def thumbnail
    @thumbnail ||= LinkThumbnailer.generate(self.link)
  end

  def post_title
    return self.title unless title = thumbnail.title
    if title.length < 60
      return title
    else
      return title[0..57] + "..."
    end
  end

  def description
    desc = thumbnail.description
    if desc.length < 110
      return desc
    else
      return desc[0..107] + "..."
    end
  end

  def favicon
    thumbnail.favicon
  end

  def image
    thumbnail = LinkThumbnailer.generate(self.link)
    img = thumbnail.images.first.src.to_s
  end

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
  
  #Methods to Query like and dislikes of post

  def pos_votes
    self.votes.where({value: 1})
  end

  def neg_votes
    self.votes.where({value: -1})
  end

  def pos_ids
    pos_votes.collect {|vote| vote.user_id}
  end
  
  def neg_ids
    neg_votes.collect {|vote| vote.user_id}
  end

  def pos_users
    User.where({id: pos_ids})
  end

  def neg_users
    User.where({id: neg_ids})
  end

  # GETTING USER POSTS (some sister methods in User Model)
  # =======================================================

  def self.get_user_posts(user)
    self.joins(:user).where(users: {id: user.id})
  end

  def self.get_user_posts_by_following(user)
    following_ids = user.following.map(&:id)
    Post.where(user_id: following_ids).order('created_at DESC')
  end

  # post.get_poster_name #=> jabba_the_hutt_b0i__460
  def get_poster_name
    User.joins(:posts).where(posts: {id: self.id}).pluck(:name).take(1).join
  end

  def is_new_post?
    seconds = Time.now - self.created_at
    seconds < 300 ? true : false
  end

  def get_post_date
    if is_new_post?
      "just now!"
    else
      self.created_at.strftime('on %a, %D @ %l:%M %P')
    end
  end

  # def autosave_associated_records_for_tags
  #   byebug
  # end

  private

    # only admin need this method
    def get_user_posts_by_following
    self.following.collect do |followed|
      followed.get_user_posts
    end
  end




end
