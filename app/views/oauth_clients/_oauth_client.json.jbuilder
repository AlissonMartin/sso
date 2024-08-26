json.extract! oauth_client, :id, :name, :app_id, :app_secret, :created_at, :updated_at
json.url oauth_client_url(oauth_client, format: :json)
