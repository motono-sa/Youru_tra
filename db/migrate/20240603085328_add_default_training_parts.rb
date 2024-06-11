class AddDefaultTrainingParts < ActiveRecord::Migration[7.1]
  def up
    training_parts = ['腕', '胸部', '背中', 'お腹', '脚', '全身']
    training_parts.each do |part|
      TrainingPart.create(name: part)
    end
  end

  def down
    TrainingPart.where(name: ['腕', '胸部', '背中', 'お腹', '脚', '全身']).delete_all
  end
end
