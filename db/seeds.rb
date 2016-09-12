require 'faker'

# makin' users (name:, email:, password:)
user = User.create(name: "George", email: "george@thebeatles.com", password: "password")
user = User.create(name: "John", email: "john@thebeatles.com", password: "password")
user = User.create(name: "Ringo", email: "ringo@thebeatles.com", password: "password")
user = User.create(name: "Paul", email: "paul@thebeatles.com", password: "password")

# makin' more users
gurlz = []

20.times do
	gurlz << User.new(name: Faker::Pokemon.name.downcase + "_gUR1_" + Faker::Number.between(111, 528).to_s, password: "password")
end

# makin' unique email addys
gurlz.each do |gurl|
	gurl.email = Faker::Internet.safe_email(gurl.name)
	gurl.save
end


# makin' a few more users
boiz = []

20.times do
	boiz << User.new(name: Faker::StarWars.character.downcase.split.join("_") + "_b0i__" + Faker::Number.between(131, 721).to_s, password: "password")
end

# making email addys
boiz.each do |boi|
	boi.email = Faker::Internet.safe_email(boi.name)
	boi.save
end


# Assigning posts to users
User.all.each do |user|
	user.posts.build(title: "#{Faker::Number.between(7, 34).to_s} Unbelievable Ways #{Faker::Hipster.word.capitalize} #{Faker::Music.instrument.pluralize} Are Wrecking Your Marriage", link: "http://www.nytimes.com/2016/09/08/fashion/new-york-fashion-week-history-first-shows.html")
	user.posts.build(title: "#{Faker::Number.between(7, 34).to_s} Salads That Improve Your #{Faker::Music.instrument} Playing", link: "http://www.ew.com/article/2016/08/17/cher-studio-new-album")
	user.posts.build(title: "Love #{Faker::Hacker.noun.capitalize.pluralize}? Here's #{Faker::Number.between(999, 3099).to_s} Simple Crafts You Can Make With Your Kids!", link: "http://www.theonion.com/article/horrible-facebook-algorithm-accident-results-expos-53841")
	user.save
end

# create tags
Tag.create(name: "funny")
Tag.create(name: "cats")
Tag.create(name: "dogs")
Tag.create(name: "gross")
Tag.create(name: "political")
Tag.create(name: "flatiron")
Tag.create(name: "beyonce")
Tag.create(name: "helpful")

Post.all.each do |post|
	post.tags = Tag.all.sample(2)
end
1000.times do
Post.all.sample.votes << Vote.new(user_id: User.all.sample.id, value: 1)
end

750.times do
	Post.all.sample.votes << Vote.new(user_id: User.all.sample.id, value: (-1))
end
