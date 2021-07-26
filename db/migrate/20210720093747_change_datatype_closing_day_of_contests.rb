class ChangeDatatypeClosingDayOfContests < ActiveRecord::Migration[6.1]
  def change
    change_column :contests, :closing_day, 'integer USING CAST(closing_day AS integer)'
  end
end
