class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :photos, dependent: :destroy
  has_many :photo_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :boards, dependent: :destroy
  has_many :posts, dependent: :destroy

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/icon_127790_256.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'icon_136700_256.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
  
  def own?(object)
    object.user_id == id
  end
end
