class UpdateOauthClients < ActiveRecord::Migration[7.0]
  def change
    add_column :oauth_clients, :deleted_at, :datetime
  end
end
