# == Schema Information
#
# Table name: children
#
#  id            :integer          not null, primary key
#  date_of_birth :string
#  gender        :string
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  caregiver_id  :integer
#
class Child < ApplicationRecord
  belongs_to :caregiver, required: true, class_name: "User", foreign_key: "caregiver_id"
  has_many  :analyses, class_name: "Analysis", foreign_key: "child_id", dependent: :destroy
  has_many  :allergies, class_name: "Allergy", foreign_key: "child_id", dependent: :destroy
  has_many  :meals, class_name: "Meal", foreign_key: "child_id", dependent: :destroy
end
