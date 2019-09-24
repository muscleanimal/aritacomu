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
 has_many :links
 has_many :sharings, through: :links, source: :share,dependent: :destroy
 has_many :comments, dependent: :destroy
  has_one_attached :avatar,dependent: :destroy # 追記

attribute :new_avatar
validate :avatar_validation

  def avatar_validation
    if avatar.attached?

      if avatar.blob.byte_size > 1000000
        avatar.purge
        errors.add(:new_avatar, :too_big)

      elsif !avatar.blob.content_type.in?(ALLOWED_CONTENT_TYPES)
        avatar.purge
        errors.add(:new_avatar, :wrong)
      end
          else
      errors.add(:new_avatar, :presence)
    end
  end



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

   def share(other_share)
      self.links.find_or_create_by(share_id: other_share.id)
   end

  def unshare(other_share)
    link = self.links.find_by(share_id: other_share.id)
    link.destroy if link
  end

  def share?(other_share)
    self.sharings.include?(other_share)
  end

end
