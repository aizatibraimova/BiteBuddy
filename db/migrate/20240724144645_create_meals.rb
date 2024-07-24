class CreateMeals < ActiveRecord::Migration[7.1]
  def change
    create_table :meals do |t|
      t.integer :food_id
      t.text :notes
      t.datetime :date
      t.integer :child_id
      t.string :quantity

      t.timestamps
    end
  end
end
