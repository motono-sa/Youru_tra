class Video < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true
  
  # カレンダーに検索した動画のタイトルを表示するため,部位のカウントのため
  belongs_to :training_part
  has_many :user_video_searches
  has_many :users, through: :user_video_searches

  def embed_url
    url.gsub('watch?v=', 'embed/')
  end
  
end