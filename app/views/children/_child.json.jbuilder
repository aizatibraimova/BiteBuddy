json.extract! child, :id, :name, :dob, :gender, :caregiver_id, :created_at, :updated_at
json.url child_url(child, format: :json)
