# app/services/child_data_service.rb
class ChildDataService
  def initialize(child, start_date, end_date)
    @child = child
    @start_date = start_date
    @end_date = end_date
  end

  def prepare_data
    meals = fetch_meals.to_a
    allergies = fetch_allergies.to_a

    { meals: meals, allergies: allergies }
  end

  private

  def fetch_meals
    @child.meals.where(date: @start_date..@end_date)
  end

  def fetch_allergies
    @child.allergies.where(detected_date: @start_date..@end_date)
  end
end
