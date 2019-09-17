class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
 has_many :answers
 has_many :infos
 has_many :works
 has_many :mentions
 has_many :favorites
 has_many :likes, through: :favorites, source: :work
 has_many :shares 
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
