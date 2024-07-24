json.extract! child, :id, :name, :date_of_birth, :gender, :caregiver_id, :created_at, :updated_at
json.url child_url(child, format: :json)
