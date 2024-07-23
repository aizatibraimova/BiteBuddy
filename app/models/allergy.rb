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
  belongs_to :child
  has_many :analyses
end
