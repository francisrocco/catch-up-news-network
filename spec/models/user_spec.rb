require "rails_helper"

describe User do
   let(:user_1) {User.create(name: "Bob", password: "password", email: "bob@yahoo.com")}
   let(:user_2) {User.create(name: "Alice", password: "alicepassword", email: "alice@yahoo.com")}
   let(:user_3) {User.create(name: "Charlie", password: "charliepassword", email: "charlie@yahoo.com")}

	describe '#follow' do 
		it "associates a user to a follower" do
		  user_1.follow(user_2)
		  expect(user_2.followers).to include(user_1) 
		end
	end

	describe '#followers_count' do 
		it "counts the number of followers" do
		  user_1.follow(user_2)
		  expect(user_2.followers_count).to eq(1) 
		end
	end

	describe '#following_count' do 
		it "counts the number of people you follow" do
		  user_1.follow(user_2)
		  expect(user_1.following_count).to eq(1) 
		end
	end

    describe '#has_followers?' do 
		it "returns true if user have followers" do
		  user_1.follow(user_2)
		  expect(user_2.has_followers?).to be(true) 
		end
		it "returns false if user have followers" do
		  expect(user_3.has_followers?).to be(false) 
		end
	end	
end

