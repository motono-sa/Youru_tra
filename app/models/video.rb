class Video < ApplicationRecord
  has_many :user_video_searches
  has_many :training_parts, through: :user_video_searches

  def embed_url
    url.gsub('watch?v=', 'embed/')
  end
end
