
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


# making users
user = User.create(name: "George", email: "george@thebeatles.com")
user = User.create(name: "John", email: "john@thebeatles.com")
user = User.create(name: "Ringo", email: "ringo@thebeatles.com")
user = User.create(name: "Paul", email: "paul@thebeatles.com")

# I hard-coded the email addresses because I had a hunch they ought to be unique
User.create(name: Faker::Pokemon.name.downcase + "gurl_" + Faker::Number.number(4), email: honeybear@booboo.com )
User.create(name: Faker::Pokemon.name.downcase + "_gurl" + Faker::Number.number(3), email: diamond@rock.com )
User.create(name: Faker::Pokemon.name.downcase + "gurl_" + Faker::Number.number(6), email: cowssaymoo@gmail.com )

5.times do 

User.new(name: Faker::)

end