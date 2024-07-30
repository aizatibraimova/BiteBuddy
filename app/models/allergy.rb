# == Schema Information
#
# Table name: allergies
#
#  id            :integer          not null, primary key
#  description   :string
#  detected_date :date
#  notes         :text
#  severity      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  child_id      :integer
#
class Allergy < ApplicationRecord
  belongs_to :child, required: true, class_name: "Child", foreign_key: "child_id"
  has_many  :analyses, class_name: "Analysis", foreign_key: "allergy_id", dependent: :destroy

  validates :description, :detected_date, :severity, presence: true
end
