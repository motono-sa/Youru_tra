class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true

  # ユーザーがその日初めて検索するか確認するメソッド
  def can_search?
    return true if last_search_at.nil?
    last_search_at < Time.zone.now.beginning_of_day
  end

  # 検索を記録するメソッド
  def record_search
    update(last_search_at: Time.zone.now)
  end
end