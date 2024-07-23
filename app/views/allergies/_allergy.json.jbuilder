json.extract! allergy, :id, :description, :severity, :detected_date, :notes, :child_id, :created_at, :updated_at
json.url allergy_url(allergy, format: :json)
