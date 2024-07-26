# == Schema Information
#
# Table name: meals
#
#  id         :integer          not null, primary key
#  date       :datetime
#  notes      :text
#  quantity   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  child_id   :integer
#  food_id    :integer
#
class Meal < ApplicationRecord
  belongs_to :child, required: true, class_name: "Child", foreign_key: "child_id"
  belongs_to :food, required: true, class_name: "Food", foreign_key: "food_id"
  has_many  :analyses, class_name: "Analysis", foreign_key: "meal_id", dependent: :destroy

  validates :food_id, :notes, :date, :quantity, presence: true
end
