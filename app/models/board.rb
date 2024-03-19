class Board < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :posts, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  
  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "title", "updated_at", "user_id"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    []
  end
end
