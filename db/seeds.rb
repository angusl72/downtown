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

# Create test user
User.create!(
  email: "test@test.com",
  password: "123456",
  username: "test",
  city: "Sydney, Australia"
)
puts "Test User Created"

# Creating 10 users
4.times do
  user = User.create!(
    username: Faker::Internet.username,
    email: Faker::Internet.email,
    password: "123456",
    city: "Sydney, Australia"
  )
  puts "Creating User: #{user.username}"

  # Creating 2 images per user
  2.times do
    image = Image.create!(
      user_id: user.id,
      address: Faker::Address.full_address,
      options: Array.new([%w[trees bicycle cafe green mural].sample])
    )
    puts "Img Adddress: #{image.address}"

    # Before photo
<<<<<<< HEAD
    image.before_photo_base_url = [
      "https://maps.googleapis.com/maps/api/streetview?size=640x400&location=161%20Richardson%20St&key=#{ENV['GOOGLE_STREET_VIEW_API_KEY']}",
      "https://maps.googleapis.com/maps/api/streetview?size=640x400&location=13%20rickard%20ave&key=#{ENV['GOOGLE_STREET_VIEW_API_KEY']}",
      "https://maps.googleapis.com/maps/api/streetview?size=640x400&location=103%20canning%20st&key=#{ENV['GOOGLE_STREET_VIEW_API_KEY']}",
      "https://maps.googleapis.com/maps/api/streetview?size=640x400&heading=1&location=103%20canning%20st&key=#{ENV['GOOGLE_STREET_VIEW_API_KEY']}",
      "https://maps.googleapis.com/maps/api/streetview?size=640x400&heading=90&location=161%20collins%20st%20melbourne&key=#{ENV['GOOGLE_STREET_VIEW_API_KEY']}"
    ].sample
=======
    # image.before_photo.attach(io: File.open(Rails.root.join("app/assets/images/#{image_no}.jpg")), filename: "#{image.id}-before.jpg")
    image.before_photo = ["https://maps.googleapis.com/maps/api/streetview?size=640x400&location=161%20Richardson%20St&key=#{ENV.fetch("STREET_VIEW_API")}", "https://maps.googleapis.com/maps/api/streetview?size=640x400&location=13%20rickard%20ave&key=#{ENV.fetch("STREET_VIEW_API")}", "https://maps.googleapis.com/maps/api/streetview?size=640x400&location=103%20canning%20st&key=#{ENV.fetch("STREET_VIEW_API")}", "https://maps.googleapis.com/maps/api/streetview?size=640x400&heading=1&location=103%20canning%20st&key=#{ENV.fetch("STREET_VIEW_API")}", "https://maps.googleapis.com/maps/api/streetview?size=640x400&heading=90&location=161%20collins%20st%20melbourne&key=#{ENV.fetch("STREET_VIEW_API")}"].sample
>>>>>>> master
    image.save!
    puts "Before photo attached:  #{image.before_photo.attached?}"

    # After photo
    image.after_photo.attach(io: File.open(Rails.root.join("app/assets/images/#{rand(1..5)}-2.jpg")), filename: "#{image.id}-after.jpg")
    image.save!
    puts "After photo attached: #{image.after_photo.attached?}"

    # Creating 2 comments per photo
    2.times do
      Comment.create!(
        user_id: User.all.sample.id,
        image_id: image.id,
        text: Faker::Restaurant.review
      )
    end
  end
  puts "------------------------------------------"
end

puts "-----------------"
puts "---------FINISHED SEEDS!---------"
puts "-----------------"
