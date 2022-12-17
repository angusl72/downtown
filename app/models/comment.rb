class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :image
  validates :text, presence: true

  # data validations - TO DO
end
