class CreateUserPhotoLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :user_photo_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :photo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
