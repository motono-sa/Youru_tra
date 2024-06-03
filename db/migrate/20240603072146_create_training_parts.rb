class CreateTrainingParts < ActiveRecord::Migration[7.1]
  def change
    create_table :training_parts do |t|
      t.string :name

      t.timestamps
    end
  end
end
