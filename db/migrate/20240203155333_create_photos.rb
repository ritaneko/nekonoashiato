class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :image_id
      t.integer :user_id
      t.timestamps
    end
  end
end
