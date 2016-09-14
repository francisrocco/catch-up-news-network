require 'rails_helper'

describe Comment, type: :model do
  it 'has an author' do
    comment = Comment.create(message: "This is a terrible post!")
    comment.user = User.new(name: "Kung Fu Master")
    expect(comment.user.name).to eq("Kung Fu Master")
  end

  it 'belongs to a post' do
    expect(true).to eq("Kung Fu Master")
  end
end