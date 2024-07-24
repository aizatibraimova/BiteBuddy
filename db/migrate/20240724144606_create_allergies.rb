class CreateAllergies < ActiveRecord::Migration[7.1]
  def change
    create_table :allergies do |t|
      t.string :description
      t.string :severity
      t.integer :child_id
      t.date :detected_date
      t.text :notes

      t.timestamps
    end
  end
end
