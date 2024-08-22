require 'rails_helper'

RSpec.describe Child, type: :model do
  it "is valid with valid attributes" do
    caregiver = User.create(
      email: Faker::Internet.email, 
      password: Faker::Internet.password(min_length: 8)
    )
    child = Child.new(
      name: Faker::Name.name, 
      date_of_birth: Faker::Date.birthday(min_age: 0, max_age: 5), 
      gender: ["male", "female"].sample,
      caregiver: caregiver
    )
    expect(child).to be_valid
  end

  it "is not valid without a name" do
    child = Child.new(name: nil)
    expect(child).not_to be_valid
  end
end
