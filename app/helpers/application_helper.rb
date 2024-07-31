module ApplicationHelper
  def item_card(item, name, child = nil)
    case item
    when Meal
      {
        name: "#{link_to(name, [child, item])}
        <div>Notes: #{item.notes}</div>
        <div>Date: #{item.date&.strftime("%Y-%m-%d") || "N/A"}</div>".html_safe,
        edit_path: item.persisted? ? edit_child_meal_path(child, item) : nil,
        delete_path: item.persisted? ? child_meal_path(child, item) : nil,
      }
    when Allergy
      {
        name: "#{link_to(item.description, [child, item])}
               <div>Notes: #{item.notes}</div>
               <div>Severity: #{item.severity}</div>
               <div>Date: #{item.detected_date&.strftime("%Y-%m-%d") || "N/A"}</div>".html_safe,
        edit_path: item.persisted? ? edit_child_allergy_path(child, item) : nil,
        delete_path: item.persisted? ? child_allergy_path(child, item) : nil,
      }
    when Analysis
      {
        name: "#{link_to(item.title, [child, item])}
        <div>Notes: #{item.notes}</div>
        <div>Date: #{item.date&.strftime("%Y-%m-%d") || "N/A"}</div>".html_safe,
        edit_path: item.persisted? ? edit_child_analysis_path(child, item) : nil,
        delete_path: item.persisted? ? child_analysis_path(child, item) : nil
      }
    when Food
      {
        name: "#{link_to(item.name, item)}".html_safe,
        edit_path: item.persisted? ? edit_food_path(item) : nil,
        delete_path: item.persisted? ? food_path(item) : nil
      }
    when Child
      {
        name: "#{link_to(item.name, item)}".html_safe,
        edit_path: item.persisted? ? edit_child_path(item) : nil,
        delete_path: item.persisted? ? child_path(item) : nil
      }
    else
      {}
    end
  end
end
