# == Schema Information
#
# Table name: analyses
#
#  id              :integer          not null, primary key
#  date            :date
#  findings        :string
#  recommendations :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  allergy_id      :integer
#  child_id        :integer
#  meal_id         :integer
#
class Analysis < ApplicationRecord
  belongs_to :child, required: true, class_name: "Child", foreign_key: "child_id"
  belongs_to :meal, required: true, class_name: "Meal", foreign_key: "meal_id"
  belongs_to :allergy, required: true, class_name: "Allergy", foreign_key: "allergy_id"

  # validates :findings, presence: true
  # validates :recommendations, presence: true
  # validates :date, presence: true
end
