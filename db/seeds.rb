# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

include Devise::Controllers::Helpers

user1 = User.new({ name: 'Pepe', email: 'pepe@gmail.com', password: '123456', password_confirmation: '123456' })
user2 = User.new({ name: 'Manolo', email: 'manolo@gmail.com', password: '654321', password_confirmation: '654321' })

confirmation_token = Devise.token_generator.generate(User, :confirmation_token)
user1.confirmation_token = confirmation_token[0]
user1.confirmed_at = Time.now.utc

if user1.save!
  puts 'First user created successfully...'
end

confirmation_token = Devise.token_generator.generate(User, :confirmation_token)
user2.confirmation_token = confirmation_token[0]
user2.confirmed_at = Time.now.utc

if user2.save!
  puts 'Second user created successfully...'
end

group1 = Group.create({name: 'Sport', icon: 'https://cdn-icons-png.flaticon.com/512/2112/2112215.png', user_id: 1})
group2 = Group.create({name: 'Gaming', icon: 'https://cdn-icons-png.flaticon.com/512/3588/3588658.png', user_id: 1})

Operation.create([
    {name: 'Tennis raquet', amount: 325, user_id: 1},
    {name: 'Baseball Bat', amount: 135, user_id: 1}
])
