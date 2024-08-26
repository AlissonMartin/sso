class CreateOauthClients < ActiveRecord::Migration[7.0]
  def change
    create_table :oauth_clients do |t|
      t.string :name
      t.string :app_id
      t.string :app_secret

      t.timestamps
    end
  end
end
