class AddUniqueIndexToUserSearchHistories < ActiveRecord::Migration[7.1]
  def change
    add_index :user_search_histories, [:user_id, :searched_at], unique: true
  end
end
