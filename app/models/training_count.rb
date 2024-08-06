class TrainingCount < ApplicationRecord
  belongs_to :user
  belongs_to :training_part

  validates :count, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :month, presence: true
  validates :user_id, uniqueness: { scope: [:training_part_id, :month] }
end
