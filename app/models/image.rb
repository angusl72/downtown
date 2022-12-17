class Image < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  # data validations - TO DO

end
