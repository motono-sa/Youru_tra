class VideosController < ApplicationController
  def search
    training_part = TrainingPart.find(params[:training_part_id])
    query = training_part.name + " workout"
    service = YoutubeService.new
    response = service.search_videos(query)
    @videos = response['items'].map do |item|
      Video.create(title: item['snippet']['title'], url: "https://www.youtube.com/watch?v=#{item['id']['videoId']}")
    end
  end
end
