# app/models/access_grant.rb
class AccessGrant < ApplicationRecord
  belongs_to :user
  belongs_to :oauth_client

  before_create :generate_tokens

  # Generate random tokens
  def generate_tokens
    self.code = SecureRandom.hex(16)
    self.access_token = SecureRandom.hex(16)
    self.refresh_token = SecureRandom.hex(16)
  end

  # Delete all grants which are older than 3 days
  def self.prune!
    where("created_at < ?", 3.days.ago).delete_all
  end

  # Class method to find access grants by code and client ID
  def self.authenticate(code, application_id)
    AccessGrant.where("code = ? AND oauth_client_id = ?", code, application_id).first
  end

  # Instance method to dynamically define the redirect URI after an access grant is issued.
  def redirect_uri_for(redirect_uri)
    if redirect_uri =~ /\?/
      redirect_uri + "&code=#{code}&response_type=code&state=#{state}"
    else
      redirect_uri + "?code=#{code}&response_type=code&state=#{state}"
    end
  end

  # Note: This is currently configured through devise, and matches the AuthController access token life
  def start_expiry_period!
    self.update_attribute(:access_token_expires_at, Time.now + Devise.timeout_in)
  end

end
