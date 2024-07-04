class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true

  validates :reset_password_token, uniqueness: true, allow_nil: true

  # カレンダーに検索した動画のタイトルを表示するため
  has_many :calendar_search_title_histories
  has_many :videos, through: :calendar_search_title_histories

  # ユーザーがその日初めて検索するか確認する
  def can_search?
    # 検索していないか
    return true if last_search_at.nil?
    # 最後に検索した日が今日じゃないか
    last_search_at < Time.zone.now.beginning_of_day
  end

  # 検索した日時を記録する
  def record_search
    update(last_search_at: Time.zone.now)
  end
end