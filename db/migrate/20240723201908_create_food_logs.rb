class CreateFoodLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :food_logs do |t|
      t.integer :food_id
      t.integer :child_id
      t.date :date
      t.text :notes

      t.timestamps
    end
  end
end
