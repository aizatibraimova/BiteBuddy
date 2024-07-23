class Allergy < ApplicationRecord
  belongs_to :child
  has_many :analyses
end
