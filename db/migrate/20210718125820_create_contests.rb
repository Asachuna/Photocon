class CreateContests < ActiveRecord::Migration[6.1]
  def change
    create_table :contests do |t|
      t.string :name
      t.string :description
      t.date :closing_day
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
