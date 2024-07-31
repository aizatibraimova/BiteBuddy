module ApplicationHelper
  def meal_item(meal, child)
    {
      name: "#{link_to(meal.food.name, [child, meal])}<div>Notes: #{meal.notes}</div><div>Date: #{meal.date}</div>".html_safe,
      edit_path: edit_child_meal_path(child, meal),
      delete_path: child_meal_path(child, meal),
    }
  end

  def allergy_item(allergy, child)
    {
      name: "#{link_to("Reaction: " + allergy.description, [child, allergy])}<div>Notes: #{allergy.notes}</div><div>Severity: #{allergy.severity}</div>".html_safe,
      edit_path: edit_child_allergy_path(child, allergy),
      delete_path: child_allergy_path(child, allergy),
    }
  end
end
