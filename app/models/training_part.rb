class TrainingPart < ApplicationRecord
  has_many :user_video_searches
  has_many :videos, through: :user_video_searches
end
