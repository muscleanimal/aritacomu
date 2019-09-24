class Share < ApplicationRecord
  has_one_attached :avatar,dependent: :destroy
  belongs_to :user

  validates :content, :title, presence: true, length: { maximum: 255 }
    has_many :links,dependent: :destroy
    has_many :myshare, through: :links, source: :share
    has_many :comments,dependent: :destroy
     has_many :reverses_of_link, class_name: 'Link', foreign_key: 'user_id'
  has_many :users, through: :reverses_of_link, source: :user 

    def share?(other_share)
    self.users.include?(other_share)
  end
  
  
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
end
