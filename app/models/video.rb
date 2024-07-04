class Video < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true
  
  has_many :user_video_searches
  has_many :training_parts, through: :user_video_searches

  # カレンダーに検索した動画のタイトルを表示するため
  has_many :calendar_search_title_histories
  has_many :users, through: :calendar_search_title_histories

  def embed_url
    url.gsub('watch?v=', 'embed/')
  end
end
