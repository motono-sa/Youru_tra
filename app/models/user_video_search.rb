class UserVideoSearch < ApplicationRecord
  belongs_to :user
  belongs_to :training_part
  belongs_to :video

  def start_time
    self.date
  end
end
