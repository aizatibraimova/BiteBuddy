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
  has_many :food_logs
end
