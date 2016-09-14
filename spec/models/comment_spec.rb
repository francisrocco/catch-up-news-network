require 'rails_helper'

describe Comment, type: :model do
  describe 'associations' do
	  it 'has an author' do
	    message = Comment.create(message: "Hello")
	    message.user = User.new(name: "Cliff")

	  	expect(message.user.name).to eq("Cliff")
	  end
  end
end