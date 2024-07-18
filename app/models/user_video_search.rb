class UserVideoSearch < ApplicationRecord
  validates :date, presence: true

  belongs_to :user
  belongs_to :training_part
  belongs_to :video

  def start_time
    self.date
  end
end
