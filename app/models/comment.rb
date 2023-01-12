class Comment < ApplicationRecord
  default_scope { order('created_at DESC') }
  belongs_to :user
  belongs_to :image
  validates :text, presence: true

  # data validations - TO DO
end
