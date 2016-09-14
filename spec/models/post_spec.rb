require 'rails_helper'

describe Post, type: :model do
  describe 'Vote Methods' do


    it 'knows how many upvotes it has' do
      user = User.create(name: "RoseyCheeks", password: "FunGuy", email: "r@g.com")
      user1 = User.create(name: "BuddyBear", password: "sumpin", email: "sum@pin.com")
      good_post = Post.new(title: "Best Post", link: "Link.com")
      good_post.user = user
      good_post.save
      good_post.votes << Vote.new(value: -1, user: user)
      good_post.votes << Vote.new(value: 1, user: user1)
      expect(good_post.up_votes).to eq(1)
    end
    it 'knows how many downvotes it has' do
    end
    it 'knows its vote total' do
    end 



  end
end