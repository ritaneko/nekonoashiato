class PhotoComment < ApplicationRecord
  
  belongs_to :user
  belongs_to :photo
end
