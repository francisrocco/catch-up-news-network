
  # create_table "posts", force: :cascade do |t|
  #   t.string   "title"
  #   t.string   "link"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end

  # create_table "users", force: :cascade do |t|
  #   t.string   "name"
  #   t.string   "email"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
require 'faker'


# makin' users
user = User.create(name: "George", email: "george@thebeatles.com")
user = User.create(name: "John", email: "john@thebeatles.com")
user = User.create(name: "Ringo", email: "ringo@thebeatles.com")
user = User.create(name: "Paul", email: "paul@thebeatles.com")

# makin' more users
gurlz = []

15.times do 
	gurlz << User.new(name: Faker::Pokemon.name.downcase + "gUR1_" + Faker::Number.between(111, 528))
end

# makin' unique email addys
gurlz.each do |gurl|
	gurl.email = Faker::Internet.safe_email(gurl.name)
	gurl.save
end


# makin' a few more users
boiz = []

15.times do 
	boiz << User.new(name: Faker::StarWars.character.downcase.split.join("_") + "_b0i__" + Faker::Number.between(13, 721).to_s)
end

# making email addys
boiz.each do |boi|
	boi.email = Faker::Internet.safe_email(boi.name)
	boi.save
end