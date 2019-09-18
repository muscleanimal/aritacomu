class Work < ApplicationRecord
    belongs_to :user
    validates :content, :title, presence: true, length: { maximum: 255 }
    has_many :mentions,dependent: :destroy
    has_many :favorites,dependent: :destroy
end
