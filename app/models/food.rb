# == Schema Information
#
# Table name: foods
#
#  id         :integer          not null, primary key
#  category   :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Food < ApplicationRecord
  has_many  :meals, class_name: "Meal", foreign_key: "food_id", dependent: :destroy
end
