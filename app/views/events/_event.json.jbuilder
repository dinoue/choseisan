json.extract! event, :id, :title, :memo, :created_at, :updated_at
json.url event_url(event, format: :json)
