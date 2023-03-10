class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :username, presence: true
  has_one_attached :profile_photo
  
  # data validations - TO DO
  
end
