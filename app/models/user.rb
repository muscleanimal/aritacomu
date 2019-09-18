class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
 has_many :answers,dependent: :destroy
 has_many :infos,dependent: :destroy
 has_many :works, dependent: :destroy
 has_many :mentions, dependent: :destroy
 has_many :favorites, dependent: :destroy
 has_many :likes, through: :favorites, source: :work,dependent: :destroy
 has_many :shares, dependent: :destroy
   def like(other_work)
      self.favorites.find_or_create_by(work_id: other_work.id)
   end

  def unlike(other_work)
    favorite = self.favorites.find_by(work_id: other_work.id)
    favorite.destroy if favorite
  end

  def like?(other_work)
    self.likes.include?(other_work)
  end
  
  
end
