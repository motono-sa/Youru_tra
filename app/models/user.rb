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

  # ユーザーがその日初めて検索するか確認する
  def can_search?
    last_search = user_search_histories.where(searched_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day).last
    last_search.nil?
  end

end