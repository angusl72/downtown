# NOTE need to disable after_create :attach_before_photo in the model before running seed

puts "Cleaning users.."
User.destroy_all
puts "Cleaning Images.."
Image.destroy_all
Comment.destroy_all
puts ""
puts "Creating Accounts.."

User.create!(
  email: "shawn@outlook.com",
  password: "shawn1234",
  username: "Shawn",
  city: "Sydney, Australia"
)
puts "User Shawn Created"

User.create!(
  email: "Angus@outlook.com",
  password: "angus1234",
  username: "Angus",
  city: "Melbourne, Australia"
)
puts "User Angus Created"

User.create!(
  email: "Priyanka@outlook.com",
  password: "priyanka1234",
  username: "Priyanka",
  city: "Sydney, Australia"
)
puts "User Priyanka Created"

User.create!(
  email: "Ahmet@outlook.com",
  password: "ahmet1234",
  username: "Ahmet",
  city: "Perth, Australia"
)
puts "User Ahmet Created"

def create_user_image_comments(object)
  puts "---------------------------"
  user = User.create!(
    email: object[:email],
    password: object[:password],
    username: object[:username],
    city: object[:city]
  )

  puts "User #{user.username} Created"

  image = Image.create!(
    user_id: user.id,
    address: object[:full_address],
    options: object[:options],
    image_saved: true,
    before_photo_base_url: "https://maps.googleapis.com/maps/api/streetview?size=640x512&location=#{object[:full_address]}&key=#{ENV['GOOGLE_STREET_VIEW_API_KEY']}"
  )

  puts "Img Adddress: #{image.address}"
  image.before_photo.attach(io: File.open(Rails.root.join("app/assets/images/seed/#{object[:image_name]}.jpeg")), filename: "before_photo_#{image.id}.jpg")
  puts "Before photo attached:  #{image.before_photo.attached?}"
  # After photo
  image.after_photo.attach(io: File.open(Rails.root.join("app/assets/images/seed/#{object[:image_name]} - AI.jpeg")), filename: "#{image.id}-after.jpg")
  image.save!
  puts "After photo attached: #{image.after_photo.attached?}"

  puts "-----Creating comments-----"
  comment = Comment.create!(
    user_id: User.all.excluding(User.last).sample.id,
    image_id: image.id,
    text: object[:comment_one]
  )
  puts "#{comment.user.username} - #{comment.text}"

  comment = Comment.create!(
    user_id: User.all.excluding(User.last).sample.id,
    image_id: image.id,
    text: object[:comment_two]
  )
  puts "#{comment.user.username} - #{comment.text}"
  puts "-----Finished comments-----"
end

object = {
  email: "amelia92@outlook.com",
  password: "amelia921234",
  username: "Amelia92",
  city: "Sydney, Australia",

  full_address: "8 Elizabeth St, Sydney, New South Wales",
  options: %w[restaurant],
  image_name: "8 Elizabeth St",

  comment_one: "Would love to eat there!",
  comment_two: "Looks so nice"
}
create_user_image_comments(object)

# image = Image.create!(
#   user_id: user.id,
#   address: "8 Waldron Rd, Kincumber, New South Wales",
#   options: %w[playground],
#   image_saved: true,
#   before_photo_base_url: "https://maps.googleapis.com/maps/api/streetview?size=640x512&location=8 Waldron Rd Kincumber New South Wales&key=#{ENV['GOOGLE_STREET_VIEW_API_KEY']}"
# )
# photo = "8 Waldron Rd - AI.jpeg"
# puts "Img Adddress: #{image.address}"
# puts "Before photo attached:  #{image.before_photo.attached?}"
# # After photo
# image.after_photo.attach(io: File.open(Rails.root.join("app/assets/images/seed/#{photo}")), filename: "#{image.id}-after.jpg")
# image.save!
# puts "After photo attached: #{image.after_photo.attached?}"

# puts "-----Creating comments-----"
# Comment.create!(
#   user_id: User.all.sample.id,
#   image_id: image.id,
#   text: "Perfect spot for it"
# )
# Comment.create!(
#   user_id: User.all.sample.id,
#   image_id: image.id,
#   text: "We need more of those around"
# )


puts "---------------------------"










puts "-----------------"
puts "---------FINISHED SEEDS!---------"
puts "-----------------"
