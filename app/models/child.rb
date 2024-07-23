class Child < ApplicationRecord
  belongs_to :caregiver, class_name: "User"
end
