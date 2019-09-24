class Work < ApplicationRecord
    belongs_to :user
      has_one_attached :avatar,dependent: :destroy
    validates :content, :title,  presence: true, length: { maximum: 255 }
    has_many :mentions,dependent: :destroy
    has_many :favorites,dependent: :destroy

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
