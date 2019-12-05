# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do
    user = User.create(name: Faker::Name.name, email: Faker::Internet.email, password: "123456", password_confirmation: "123456")
    10.times do
        user.posts.create(content: Faker::Lorem.paragraph)
    end
end
Post.all.each do |p|
   users = User.all.sample(2)
   users.each do |u|
    u.comments.create(content: Faker::Lorem.paragraph, post_id: p.id)
   end
   users = User.all.sample(rand(1..4))
   users.each do |u|
    u.like(p)
   end
end