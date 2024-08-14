# db/seeds.rb

require "faker"

# Clear existing data
Child.destroy_all
Food.destroy_all
Meal.destroy_all
Allergy.destroy_all
User.destroy_all

# Specific symptoms for allergy descriptions
allergy_descriptions = [
  "Rash",
  "Vomiting",
  "Diarrhea",
  "Cramps",
  "Hives",
  "Swelling",
  "Eczema",
  "Itching or swelling of the lips, tongue, or mouth",
  "Itching or tightness in the throat",
  "Difficulty breathing",
  "Wheezing",
  "Lowered blood pressure",
]

# Foods suitable for infants and toddlers
infant_toddler_foods = [
  "Mashed Bananas",
  "Pureed Peas",
  "Steamed Carrots",
  "Avocado Slices",
  "Oatmeal",
  "Rice Cereal",
  "Applesauce",
  "Sweet Potato Puree",
  "Scrambled Eggs",
  "Yogurt",
  "Soft Cheese",
  "Tofu Cubes",
  "Chicken Puree",
  "Steamed Broccoli",
  "Soft Pear Slices",
]

test_user = User.create!(
  email: "testuser@example.com", # Specific email for testing
  password: "password",
  password_confirmation: "password",
)

4.times do
  User.create!(
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password",
  )
end

# Seed children
5.times do
  Child.create!(
    name: Faker::Name.first_name,
    date_of_birth: Faker::Date.birthday(min_age: 1, max_age: 5),
    gender: ["Male", "Female"].sample,
    caregiver_id: User.order("RANDOM()").first.id, # Assigning a caregiver
  )
end

# Seed foods with infant and toddler-friendly options
infant_toddler_foods.each do |food|
  Food.create!(
    name: food,
    category: "Infant/Toddler Food",
    user_id: test_user.id
  )
end

# Seed meals and allergies
Child.all.each do |child|
  10.times do
    meal = Meal.create!(
      child: child,
      food: Food.order("RANDOM()").first,
      date: Faker::Time.between(from: 30.days.ago, to: Time.now),
      quantity: ["Small", "Medium", "Large"].sample,
      notes: "",
    )

    if [true, false].sample
      Allergy.create!(
        child: child,
        description: allergy_descriptions.sample,
        detected_date: Faker::Date.between(from: 30.days.ago, to: Date.today),
        severity: ["Mild", "Moderate", "Severe"].sample,
      )
    end
  end
end

puts "Seeded #{Child.count} children, #{Food.count} foods, #{Meal.count} meals, and #{Allergy.count} allergies."
