class CreateAllergies < ActiveRecord::Migration[7.1]
  def change
    create_table :allergies do |t|
      t.string :description
      t.string :severity
      t.date :detected_date
      t.text :notes
      t.integer :child_id

      t.timestamps
    end
  end
end
