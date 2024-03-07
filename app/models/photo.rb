class Photo < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :photo_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :photo_tags, dependent: :destroy
  has_many :tags, through: :photo_tags
  
  validates :title, presence: true
  validates :image, presence: true
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.liked_photos(user, page, per_page)
    includes(:favorites)
    .where(favorites: { user_id: user.id })
    .order(created_at: :desc)
    .page(page)
    .per(per_page)
  end
  
  def save_tag(sent_tags)
     current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
     old_tags = current_tags - sent_tags
     new_tags = sent_tags - current_tags

     old_tags.each do |old|
      self.photo_tags.delete PhotoTag.find_by(tag_name: old)
     end

     new_tags.each do |new|
       new_photo_tag = PhotoTag.find_or_create_by(tag_name: new)
      self.photo_tags << new_photo_tag
     end
  end
end
