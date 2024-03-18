class Board < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :posts, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
end
