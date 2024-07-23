class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.references :training_part, null: false, foreign_key: true
      t.string :title, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
