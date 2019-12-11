class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum:50 }
    validates :introduce, length: { maximum:255 }
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                      uniqueness: { case_sensitive: false }
    has_secure_password
    
    has_many :posts, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :likes_posts, through: :likes, source: :post
    
    def already_liked?(post)
        self.likes.exists?(post_id: post.id)
    end
end
