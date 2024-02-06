class CreatePhotoComments < ActiveRecord::Migration[6.1]
  def change
    create_table :photo_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :photo_id

      t.timestamps
    end
  end
end
