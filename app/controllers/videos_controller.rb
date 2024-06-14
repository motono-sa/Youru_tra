class VideosController < ApplicationController
  skip_before_action :require_login, only: %i[index show search search_limit]
  before_action :check_search_limit, only: [:search]

  def search
    if can_search?
      training_part = TrainingPart.find(params[:training_part_id])
      service = YoutubeService.new
      video_data = service.search_random_video(training_part.name)
      @video = Video.find_or_create_by(url: "https://www.youtube.com/watch?v=#{video_data['id']['videoId']}") do |video|
        video.title = video_data['snippet']['title']
      end
      record_search
      save_search_result(@video)
    else
      flash[:alert] = "1日1回の検索制限があります。"
      redirect_to search_limit_videos_path
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  def search_limit
    @video = load_last_search_result
  end

  private

  def can_search?
    if current_user
      current_user.can_search?
    else
      return true if session[:last_search_at].nil?
      session[:last_search_at] < Time.zone.now.beginning_of_day
    end
  end

  def record_search
    if current_user
      current_user.record_search
    else
      session[:last_search_at] = Time.zone.now
    end
  end

  def check_search_limit
    unless can_search?
      flash[:alert] = "1日1回の検索制限があります。"
      redirect_to search_limit_videos_path
    end
  end

  def save_search_result(video)
    if current_user
      current_user.update(last_searched_video_url: video.url, last_searched_video_title: video.title, last_searched_video_id: video.id)
    else
      session[:last_searched_video_url] = video.url
      session[:last_searched_video_title] = video.title
      session[:last_searched_video_id] = video.id
    end
  end

  def load_last_search_result
    if current_user
      OpenStruct.new(url: current_user.last_searched_video_url, title: current_user.last_searched_video_title, id: current_user.last_searched_video_id)
    else
      OpenStruct.new(url: session[:last_searched_video_url], title: session[:last_searched_video_title], id: session[:last_searched_video_id])
    end
  end
end