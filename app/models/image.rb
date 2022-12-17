class Image < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :before_photo
  has_one_attached :after_photo
  # data validations - TO DO

end
