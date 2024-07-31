module ApplicationHelper
  def item_card(item, name, child = nil)
    case item
    when Meal
      {
        name: "#{link_to(name, [child, item])}<div>Notes: #{item.notes}</div><div>Date: #{item.date.strftime('%Y-%m-%d')}</div>".html_safe,
        edit_path: edit_child_meal_path(child, item),
        delete_path: child_meal_path(child, item)
      }
    when Allergy
      {
        name: "#{link_to('Reaction: ' + item.description, [child, item])}<div>Notes: #{item.notes}</div><div>Severity: #{item.severity}</div><div>Date: #{item.detected_date.strftime('%Y-%m-%d')}</div>".html_safe,
        edit_path: edit_child_allergy_path(child, item),
        delete_path: child_allergy_path(child, item)
      }
    when Analysis
      {
        name: "#{link_to(item.title, [child, item])}<div>Notes: #{item.notes}</div><div>Date: #{item.date.strftime('%Y-%m-%d')}</div>".html_safe,
        edit_path: edit_child_analysis_path(child, item),
        delete_path: child_analysis_path(child, item)
      }
    when Food
      {
        name: "#{link_to(item.name, item)}".html_safe,
        edit_path: edit_food_path(item),
        delete_path: food_path(item)
      }
    when Child
      {
        name: "#{link_to(item.name, item)}".html_safe,
        edit_path: edit_child_path(item),
        delete_path: child_path(item)
      }
    else
      {}
    end
  end
end
