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

# Creating 10 users
10.times do
  user = User.create!(
    username: Faker::Internet.username,
    email: Faker::Internet.email,
    password: "123456",
  )
  puts "Creating User: #{user.username}"

  # Creating 2 images per user
  2.times do
    image = Image.create!(
      user_id: user.id,
      address: Faker::Address.full_address,
      options: %w[trees bicycle cafe green mural].sample
    )
    puts "Img Adddress: #{image.address}"
    # setting random number for image asset
    image_no = rand(1..5)
    # Before photo
    image.before_photo.attach(io: File.open(Rails.root.join("app/assets/images/#{image_no}.jpg")), filename: "#{image.id}-before.jpg")
    image.save!
    puts "Before photo attached"
    # After photo
    image.after_photo.attach(io: File.open(Rails.root.join("app/assets/images/#{image_no}-2.jpg")), filename: "#{image.id}-after.jpg")
    image.save!
    puts "After photo attached"
    # Creating 2 comments per photo
    2.times do
      comment = Comment.create!(
        user_id: User.all.sample.id,
        image_id: image.id,
        text: Faker::Restaurant.review
      )
    end
  end
  puts "------------------------------------------"
end

puts""
puts "Finished!"
