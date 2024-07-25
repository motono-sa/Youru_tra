class CreateUserSearchHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :user_search_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :video, null: false, foreign_key: true
      t.datetime :searched_at

      t.timestamps
    end
  end
end
