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
        video.training_part = training_part
      end
      # カレンダーに検索した動画のタイトルを表示するために記録する
      if @video && current_user
        current_user.user_video_searches.create(video: @video, date: Time.zone.today)
      end
      save_search_result(@video)
    else
      redirect_to search_limit_videos_path, warning: '1日1回の検索制限があります'
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  # 検索制限の時に表示されるページ
  def search_limit
    @video = load_last_search_result
  end

  private

  # 検索可能か確認する
  def can_search?
    if current_user
      current_user.can_search?
    else
      return true if session[:last_search_at].nil?
      session[:last_search_at] < Time.zone.now.beginning_of_day
    end
  end

  # 検索を記録する
  def record_search
    if current_user
      current_user.record_search(@video)
    else
      session[:last_search_at] = Time.zone.now
    end
  end

  # 検索制限をチェックして、制限されている場合は検索制限時のページへいく
  def check_search_limit
    unless can_search?
      redirect_to search_limit_videos_path, warning: '1日1回の検索制限があります'
    end
  end

  # 検索結果をユーザーもしくはセッションに保存する
  def save_search_result(video)
    if current_user
      # 現在の日付を取得
      today = Time.zone.today.beginning_of_day
      # ユーザーの検索履歴を取得（存在しない場合は新規作成）
      search_history = current_user.user_search_histories.find_or_initialize_by(searched_at: today)
      # 検索履歴を更新
      search_history.update(video: video, searched_at: Time.zone.now)
    else
      session[:last_searched_video_url] = video.url
      session[:last_searched_video_title] = video.title
      session[:last_searched_video_id] = video.id
    end
  end

  # 最後に検索した動画の情報を読み込む
  def load_last_search_result
    if current_user
      last_search = current_user.user_search_histories.order(searched_at: :desc).first
      if last_search
        video = last_search.video
        VideoStruct.new(url: video.url, title: video.title, id: video.id)
      else
        VideoStruct.new(url: nil, title: nil, id: nil)
      end
    else
      VideoStruct.new(url: session[:last_searched_video_url], title: session[:last_searched_video_title], id: session[:last_searched_video_id])
    end
  end
end