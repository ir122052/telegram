class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :likes_users, through: :likes, source: :user
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :image, presence: true
  
  mount_uploader :image, ImageUploader
end
