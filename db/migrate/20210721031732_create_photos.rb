class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.string :title
      t.string :description
      t.string :image
      t.references :user, null: false, foreign_key: true
      t.references :contest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
