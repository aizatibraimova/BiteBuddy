# == Schema Information
#
# Table name: food_logs
#
#  id         :integer          not null, primary key
#  date       :date
#  notes      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  child_id   :integer
#  food_id    :integer
#
class FoodLog < ApplicationRecord
  belongs_to :child
  belongs_to :food
end
