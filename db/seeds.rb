# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

puts "Cleaning users.."
User.destroy_all
puts "Cleaning Images.."
Image.destroy_all
Comment.destroy_all
puts ""
puts "Creating Test account.."
test_user = User.create!(
  email: "test@test.com",
  password: "123456",
  username: "test"
)
puts "test@test.com"
puts ""

# Creating 10 users and 2 images each
2.times do
  user = User.create!(
    username: Faker::Internet.username,
    email: Faker::Internet.email,
    password: "123456",
  )
  puts "Creating User: #{user.username}"
  2.times do
    image = Image.create!(
      user_id: user.id,
      address: Faker::Address.full_address,
      options: %w[trees bicycle cafe green mural].sample
    )
    puts "Img Adddress: #{image.address}"
    image.before_photo.attach(io: File.open(Rails.root.join("app/assets/images/#{rand(1..5)}.jpg")), filename: "#{image.id}.jpg")
    image.save!
    # puts "Photo attached? #{Image.before_photo.attached?}"
  end
  puts "------------------------------------------"
end

puts""
puts "Finished!"
