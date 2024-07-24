json.extract! allergy, :id, :description, :severity, :child_id, :detected_date, :notes, :created_at, :updated_at
json.url allergy_url(allergy, format: :json)
