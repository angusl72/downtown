class Image < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :before_photo
  has_one_attached :after_photo
  # data validations - TO DO

  OPTIONS = ["Trees", "Bicycles", "Cafe", "Greenery", "Mural", "Colour", "Flowers", "Colourful Lights", "Snow"]

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
