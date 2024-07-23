# == Schema Information
#
# Table name: analyses
#
#  id              :integer          not null, primary key
#  date            :date
#  findings        :text
#  recommendations :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  allergy_id      :integer
#  child_id        :integer
#  food_log_id     :integer
#
class Analysis < ApplicationRecord
  belongs_to :child
  belongs_to :food_log
  belongs_to :allergy
end
