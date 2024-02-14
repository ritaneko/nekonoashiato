class AddTagNameToPhotos < ActiveRecord::Migration[6.1]
  def change
    add_column :photos, :tag_name, :string
  end
end
