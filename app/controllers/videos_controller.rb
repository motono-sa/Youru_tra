class VideosController < ApplicationController
  skip_before_action :require_login, only: %i[index show search]

  def search
    training_part = TrainingPart.find(params[:training_part_id])
    service = YoutubeService.new
    video_data = service.search_random_video(training_part.name)
    @video = Video.find_or_create_by(url: "https://www.youtube.com/watch?v=#{video_data['id']['videoId']}") do |video|
      video.title = video_data['snippet']['title']
    end
  end

  def index
    @videos = Video.all
  end

  def show
    @video = Video.find(params[:id])
  end
end
