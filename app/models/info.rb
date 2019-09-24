class Info < ApplicationRecord
  belongs_to :user  
  validates :content, presence: true, length: { maximum: 255 }
    has_one_attached :avatar 
  has_many:answers,dependent: :destroy
  
  def answer_count
      @info = Info.find_by(params[:id])
      @count=@info.answers.count
end
  
  end