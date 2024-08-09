class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true

  validates :reset_password_token, uniqueness: true, allow_nil: true

  # カレンダーに検索した動画のタイトルを表示するため
  has_many :user_video_searches, dependent: :destroy
  has_many :videos, through: :user_video_searches

  # その日に検索したか調べるため
  has_many :user_search_histories, dependent: :destroy
  has_many :videos, through: :user_search_histories

  # 部位のカウント
  has_many :training_counts

  # ユーザーがその日初めて検索するか確認する
  def can_search?
    last_search = user_search_histories.where(searched_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day).last
    last_search.nil?
  end

  # 部位のカウント
  def update_training_count(training_part, date)
    month_start = date.beginning_of_month
    monthly_count = training_counts.find_or_initialize_by(training_part: training_part, month: month_start)
    monthly_count.count += 1
    monthly_count.save!
  end

  #その月の鍛えば部位の回数
  def monthly_training_counts_for_month(date)
    month_start = date.beginning_of_month
    training_parts = TrainingPart.all
    counts = training_parts.map do |part|
      training_count = training_counts.find_by(training_part: part, month: month_start)
      {
        training_part: part,
        count: training_count ? training_count.count : 0
      }
    end
    counts
  end

  # グラフを総合計にする。
  def all_training_counts
    training_parts = TrainingPart.all
    counts = training_parts.map do |part|
      total_count = training_counts.where(training_part: part).sum(:count)
      [part.name, total_count]
    end
    counts
  end

end