class TrainingPart < ApplicationRecord
  has_many :user_video_searches
  has_many :videos, through: :user_video_searches
  has_many :users, through: :user_video_searches

  # 部位のカウント
  has_many :training_counts
end
