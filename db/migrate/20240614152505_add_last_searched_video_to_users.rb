class AddLastSearchedVideoToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :last_searched_video_url, :string
    add_column :users, :last_searched_video_title, :string
    add_column :users, :last_search_at, :datetime
    add_column :users, :last_searched_video_id, :integer
  end
end
