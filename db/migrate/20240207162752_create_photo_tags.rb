class CreatePhotoTags < ActiveRecord::Migration[6.1]
  def change
    create_table :photo_tags do |t|
      t.references :photo, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
