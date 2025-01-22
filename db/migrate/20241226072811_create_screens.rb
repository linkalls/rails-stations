class CreateScreens < ActiveRecord::Migration[7.1]
  def change
    create_table :screens do |t|
      t.bigint :name

      t.timestamps
    end
  end
end
