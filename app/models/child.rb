# == Schema Information
#
# Table name: children
#
#  id           :integer          not null, primary key
#  dob          :date
#  gender       :string
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  caregiver_id :integer
#
class Child < ApplicationRecord
  belongs_to :caregiver, class_name: "User"
  has_many :food_logs
  has_many :allergies
  has_many :analyses
end
