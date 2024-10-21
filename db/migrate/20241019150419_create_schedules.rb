class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.time :start_time
      t.time :end_time
      t.references :movie, null: false, foreign_key: true # これで勝手にindexも作られる

      t.timestamps
    end
  end
end
