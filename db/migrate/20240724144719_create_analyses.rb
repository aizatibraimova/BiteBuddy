class CreateAnalyses < ActiveRecord::Migration[7.1]
  def change
    create_table :analyses do |t|
      t.integer :child_id
      t.integer :meal_id
      t.date :date
      t.string :findings
      t.text :recommendations
      t.integer :allergy_id

      t.timestamps
    end
  end
end
