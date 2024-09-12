module OauthClientsHelper
    def self.jwt_secret_key(client_id)
        OauthClient.find_by(client_id: client_id).secret_key
    end    
end
