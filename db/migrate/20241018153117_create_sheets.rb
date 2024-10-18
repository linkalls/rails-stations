class CreateSheets < ActiveRecord::Migration[7.1]
  def change
    create_table :sheets do |t|
      t.integer :column
      t.string :row
      t.timestamps
    end
  end
end
