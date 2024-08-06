class CreateTrainingCounts < ActiveRecord::Migration[7.1]
  def change
    create_table :training_counts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :training_part, null: false, foreign_key: true
      t.integer :count, default: 0
      t.date :month, null: false

      t.timestamps
    end
    add_index :training_counts, [:user_id, :training_part_id, :month], unique: true, name: 'unique_training_count'
  end
end
