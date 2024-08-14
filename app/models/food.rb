# == Schema Information
#
# Table name: foods
#
#  id         :integer          not null, primary key
#  category   :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_foods_on_user_id  (user_id)
#
class Food < ApplicationRecord
  has_many  :meals, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
end
