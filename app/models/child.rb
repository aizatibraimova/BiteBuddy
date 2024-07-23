class Child < ApplicationRecord
  belongs_to :caregiver, class_name: "User"
  has_many :food_logs
  has_many :allergies
  has_many :analyses
end
