class FoodLog < ApplicationRecord
  belongs_to :child
  belongs_to :food
end
