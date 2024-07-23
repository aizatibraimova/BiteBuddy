class CreateAnalyses < ActiveRecord::Migration[7.1]
  def change
    create_table :analyses do |t|
      t.integer :child_id
      t.integer :allergy_id
      t.integer :food_log_id
      t.date :date
      t.text :findings
      t.text :recommendations

      t.timestamps
    end
  end
end
