require 'jwt'

class JwtService
    # Descobrir um meio de passar a secret_key
    SECRET_KEY = Rails.application.credentials.secret_key_base
    ALGORITHM_TYPE = 'HS256'

    def self.encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, SECRET_KEY, ALGORITHM_TYPE)
    end

    def self.decode(token)
        decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: ALGORITHM_TYPE })
        decoded.first
    rescue JWT::DecodeError => e
        nil
    end
end