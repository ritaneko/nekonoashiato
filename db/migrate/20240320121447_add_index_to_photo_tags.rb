class AddIndexToPhotoTags < ActiveRecord::Migration[6.1]
  def change
    add_index :photo_tags, [:photo_id, :tag_id], unique: true
  end
end
