json.extract! user, :id, :name, :username, :email, :phone, :website, :created_at, :updated_at
json.url user_url(user, format: :json)
