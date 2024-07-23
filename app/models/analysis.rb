class Analysis < ApplicationRecord
  belongs_to :child
  belongs_to :food_log
  belongs_to :allergy
end
