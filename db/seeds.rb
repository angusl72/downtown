
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


def create_user(object)
  puts "---------------------------"
  user = User.create!(
    email: object[:email],
    password: object[:password],
    username: object[:username],
    city: object[:city]
  )
  puts "User #{user.username} Created"
end


def create_image_plus_comments(user, object)
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

############################################################
object = {
  email: "julie@outlook.com",
  password: "julie1234",
  username: "Julie",
  city: "Melbourne, Australia",

  full_address: "50 Canning St, North Melbourne, Victoria",
  options: %w[flowers colour],
  image_name: "50 Canning St",

  comment_one: "lovely 🌻",
  comment_two: "better get planting"
}
create_user(object)
create_image_plus_comments(User.last, object)
object = {
  full_address: "294 Arden St, North Melbourne, Victoria",
  options: %w[bar],
  image_name: "294 Arden St",

  comment_one: "so much better in that space",
  comment_two: "That would be a great idea!"
}
create_image_plus_comments(User.last, object)
a = Image.last
a.custom_option = "Nightclub"
a.save
###########################################################

############################################################
object = {
  email: "spencer90@outlook.com",
  password: "spencer901234",
  username: "Spencer90",
  city: "Melbourne, Australia",

  full_address: "376 Dryburgh St, North Melbourne, Victoria",
  options: %w[christmas snow],
  image_name: "376 Dryburgh St",

  comment_one: "I really like the images on the glass",
  comment_two: "some fake snow on the ledges would look really cool"
}
create_user(object)
create_image_plus_comments(User.last, object)
object = {
  full_address: "210 Arden St, North Melbourne, Victoria",
  options: %w[],
  image_name: "210 Arden St",

  comment_one: "interesting",
  comment_two: "what a great idea, really cool to see what it might look like"
}
create_image_plus_comments(User.last, object)
a = Image.last
a.custom_option = "Basketball courts"
a.save
###########################################################

############################################################
object = {
  email: "cat_queen@outlook.com",
  password: "cat_queen1234",
  username: "Cat_queen",
  city: "Sydney, Australia",

  full_address: "22 Orana Ave, Kirrawee, New South Wales",
  options: %w[christmas "colourful lights"],
  image_name: "22 Orana Ave",

  comment_one: "that would be so worth it",
  comment_two: "such Joy 😁"
}
create_user(object)
create_image_plus_comments(User.last, object)
###########################################################

############################################################
object = {
  email: "Skatergiirl@outlook.com",
  password: "skatergiirl1234",
  username: "skatergiirl",
  city: "Sydney, Australia",

  full_address: "232 Del Monte Pl, Copacabana, New South Wales",
  options: %w[],
  image_name: "232 Del Monte Pl",

  comment_one: "No where to skate near here",
  comment_two: "Nice 🤘🏾"
}
create_user(object)
create_image_plus_comments(User.last, object)
a = Image.last
a.custom_option = "Skate Park"
a.save
object = {
  full_address: "158 Gymea Bay Rd, Gymea, New South Wales",
  options: %w[],
  image_name: "158 Gymea Bay Rd",

  comment_one: "🛹    ",
  comment_two: "Rad!"
}
create_image_plus_comments(User.last, object)
a = Image.last
a.custom_option = "Skate Park"
a.save
object = {
  full_address: "641 Kingsway Gymea, New South Wales",
  options: %w[],
  image_name: "miranda park",

  comment_one: "Cool 😎",
  comment_two: "That is one big skate park"
}
create_image_plus_comments(User.last, object)
a = Image.last
a.custom_option = "Skate Park"
a.save
###########################################################

############################################################
object = {
  email: "jackson@outlook.com",
  password: "jackson1234",
  username: "Jackson",
  city: "Melbourne, Australia",

  full_address: "215 Fogarty St, North Melbourne, Victoria",
  options: %w[bicycles],
  image_name: "215 Fogarty St",

  comment_one: "Tour de France style! 🚵🏿‍♂️",
  comment_two: "There should be a bike lane on that road"
}
create_user(object)
create_image_plus_comments(User.last, object)
object = {
  full_address: "197 Victoria Rd, Marrickville, New South Wales",
  options: %w[cafe],
  image_name: "197 Victoria Rd",

  comment_one: "I walk past there, would be great for a coffee ☕️",
  comment_two: "wonder what they are going to put there, I like the idea of a cafe"
}
create_image_plus_comments(User.last, object)
###########################################################

############################################################
object = {
  email: "hudson@outlook.com",
  password: "hudson1234",
  username: "Hudson",
  city: "Sydney, Australia",

  full_address: "25 Boundary Rd, Kincumber, New South Wales",
  options: %w[Halloween],
  image_name: "25 Boundary Rd",

  comment_one: "Scary 👻",
  comment_two: "So much inspiration"
}
create_user(object)
create_image_plus_comments(User.last, object)
object = {
  full_address: "538 Collins St, Melbourne, Victoria",
  options: %w[mural colour],
  image_name: "538 Collins St",

  comment_one: "Hmmmm I like it!",
  comment_two: "Brightens the place up a bit"
}
create_image_plus_comments(User.last, object)
###########################################################

############################################################
object = {
  email: "brandon@outlook.com",
  password: "brandon1234",
  username: "Brandon",
  city: "Newtown, Australia",

  full_address: "181 Missenden Rd, Newtown, New South Wales",
  options: %w[bicycles],
  image_name: "181 Missenden Rd",

  comment_one: "Looks so much better with less cars",
  comment_two: "more bike racks are needed"
}
create_user(object)
create_image_plus_comments(User.last, object)
object = {
  full_address: "136 Gymea Bay Rd, Gymea, New South Wales",
  options: %w[playground],
  image_name: "136 Gymea Bay Rd",

  comment_one: "such a waste of empty space, local council needs to see this",
  comment_two: "Awesome! 😁"
}
create_image_plus_comments(User.last, object)
###########################################################

############################################################
object = {
  email: "tori89@outlook.com",
  password: "tori891234",
  username: "Tori89",
  city: "Melbourne, Australia",

  full_address: "53 Waratah St, Kirrawee, New South Wales",
  options: %w[cafe restaurant],
  image_name: "53 Waratah St",

  comment_one: "This would be great to see",
  comment_two: "a good use of the space on the weekends"
}
create_user(object)
create_image_plus_comments(User.last, object)
object = {
  full_address: "377 Swanston St, Melbourne, Victoria",
  options: %w[cafe],
  image_name: "377 Swanston St",

  comment_one: "Finally there would be a place to take my dog",
  comment_two: "Im going to send this to my local planner"
}
create_image_plus_comments(User.last, object)
a = Image.last
a.custom_option = "Community Markets"
a.save
###########################################################

############################################################
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
create_user(object)
create_image_plus_comments(User.last, object)
object = {
  full_address: "8 Waldron Rd, Kincumber, New South Wales",
  options: %w[playground],
  image_name: "8 Waldron Rd",

  comment_one: "Perfect spot for it",
  comment_two: "We need more of those around"
}
create_image_plus_comments(User.last, object)
###########################################################

############################################################
object = {
  email: "tony@outlook.com",
  password: "tony1234",
  username: "Tony",
  city: "Melbourne, Australia",

  full_address: "409 Dryburgh St, North Melbourne, Victoria",
  options: %w[flowers colour],
  image_name: "409 Dryburgh St",

  comment_one: "Looks good",
  comment_two: "Better than just plain grass"
}
create_user(object)
create_image_plus_comments(User.last, object)
object = {
  full_address: "409 Dryburgh St, North Melbourne, Victoria",
  options: %w[christmas snow],
  image_name: "409 Dryburgh St 2",

  comment_one: "Cannot wait for Christmas time! 🎄",
  comment_two: "very interesting with the snow"
}
create_image_plus_comments(User.last, object)
###########################################################

puts ""
puts "-----------------"
puts "---------FINISHED SEEDS!---------"
puts "-----------------"
