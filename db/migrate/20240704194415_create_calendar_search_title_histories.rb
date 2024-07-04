class CreateCalendarSearchTitleHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :calendar_search_title_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :video, null: false, foreign_key: true
      t.date :search_date, null: false

      t.timestamps
    end
  end
end
