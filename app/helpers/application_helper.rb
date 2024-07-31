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

  def food_item(food)
    {
      name: "#{link_to(food.name, food)}".html_safe,
      edit_path: edit_food_path(food),
      delete_path: food_path(food),
    }
  end

  def child_item(child)
    {
      name: "#{link_to(child.name, child)}".html_safe,
      edit_path: edit_child_path(child),
      delete_path: child_path(child),
    }
  end

  def analysis_item(analysis, child)
    {
      name: "#{link_to(analysis.title, [child, analysis])}<div>Notes: #{analysis.notes}</div><div>Date: #{analysis.date}</div>".html_safe,
      edit_path: edit_child_analysis_path(child, analysis),
      delete_path: child_analysis_path(child, analysis)
    }
  end
end
