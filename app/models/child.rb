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
  has_many  :allergies, dependent: :destroy
  has_many  :meals, dependent: :destroy
  has_many  :analyses, through: :meals

  validates :name, presence: true
  validates :date_of_birth, presence: true

  include RansackableAttributes
end
