class CreateChildren < ActiveRecord::Migration[7.1]
  def change
    create_table :children do |t|
      t.string :name
      t.date :dob
      t.string :gender
      t.integer :caregiver_id

      t.timestamps
    end
  end
end
