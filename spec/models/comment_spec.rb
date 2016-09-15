require 'rails_helper'

describe Comment, type: :model do
  describe 'associations' do
	  it 'has an author' do
	    message = Comment.create(message: "Hello")
	    message.user = User.new(name: "Cliff")
	  	expect(message.user.name).to eq("Cliff")
	  end
    it 'has an author' do
      comment = Comment.create(message: "This is a terrible post!")
      comment.user = User.new(name: "Kung Fu Master")
      expect(comment.user.name).to eq("Kung Fu Master")
    end

    it 'belongs to a post' do
      expect(true).to eq("Kung Fu Master")
      
    end
  end
end