class OauthClient < ApplicationRecord
  before_validation :set_attributes

  validates :name, :presence => true 

  private
    def set_attributes
      if new_record?
        generate_app_id!
        generate_app_secret!
      end
    end

    def generate_app_id!
      begin
        self.app_id = SecureRandom.hex
      end while self.class.exists?(app_id: app_id)
    end

    def generate_app_secret!
      begin
        self.app_secret = SecureRandom.hex
      end while self.class.exists?(app_secret: app_secret)
    end

  private

  def jwt_secret_key(client_id)
    OauthClient.find_by(client_id: client_id).secret_key
  end
end
