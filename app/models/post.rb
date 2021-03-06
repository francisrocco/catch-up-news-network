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

  


#method for SEARCH function
def self.search(search)
  where("name LIKE ?", "%#{search}%") 
  where("content LIKE ?", "%#{search}%")
end

  #Methods for Votes function

  def popularity
    pop = 0
    self.votes.each {|vote| pop += vote.value}
    pop
  end

  def self.most_popular
    Post.joins(:votes).group('posts.id').order('SUM(votes.value) DESC')
  end

  #Methods to Query like and dislikes of post

  def up_voters
    self.votes.where({value: 1}).collect {|vote| vote.user}
  end

  def down_voters
    self.votes.where({value: -1}).collect {|vote| vote.user}
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

  def self.all_posts_for_index(user)
    all_user_ids = []
    all_user_ids << user.following_ids
    all_user_ids << user.id
    all_user_ids.flatten!
    Post.where(user_id: all_user_ids).order('created_at DESC')
  end

  # post.get_poster_name #=> jabba_the_hutt_b0i__460
  def get_poster_name
    self.user.name
    # User.joins(:posts).where(posts: {id: self.id}).pluck(:name).take(1).join
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
