json.extract! food_log, :id, :food_id, :child_id, :date, :notes, :created_at, :updated_at
json.url food_log_url(food_log, format: :json)
