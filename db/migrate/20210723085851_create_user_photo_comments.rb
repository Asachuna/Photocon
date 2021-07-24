class CreateUserPhotoComments < ActiveRecord::Migration[6.1]
  def change
    create_table :user_photo_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :photo, null: false, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
