class RemoveTagNameFromPhotos < ActiveRecord::Migration[6.1]
  def change
    remove_column :photos, :name, :string
  end
end
