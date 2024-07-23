class User < ApplicationRecord
  has_secure_password
  has_many :children, foreign_key: :caregiver_id
end
