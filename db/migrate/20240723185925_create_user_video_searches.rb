class CreateUserVideoSearches < ActiveRecord::Migration[7.1]
  def change
    create_table :user_video_searches do |t|
      t.references :user, null: false, foreign_key: true
      t.references :video, null: false, foreign_key: true
      t.date :date, null: false

      t.timestamps
    end
  end
end
