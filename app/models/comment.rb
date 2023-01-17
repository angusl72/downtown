class Comment < ApplicationRecord
  default_scope { order('created_at DESC') }
  belongs_to :user
  belongs_to :image
  validates :text, length: { minimum: 2 }

  # data validations - TO DO
end
