class CalendarSearchTitleHistory < ApplicationRecord
  belongs_to :user
  belongs_to :video

  def start_time
    self.search_date
  end
end
