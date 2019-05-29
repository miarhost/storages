require 'jwt'
require 'openssl'

class AuthenticationToken

  RSA_PRIVATE = OpenSSL::PKey::RSA.generate 2048
  RSA_PUBLIC = RSA_PRIVATE.public_key

  def self.encode(payload) 
    begin
      token = JWT.encode(payload, RSA_PRIVATE, 'RS256')
      rescue JWT::InvalidPayload  
    end
  end

  def self.decode(token)
    begin
      return @decoded = JWT.decode(token, RSA_PUBLIC, true, { algorithm: 'RS256' })
      rescue JWT::DecodeError
    end
  end

  def self.expired(payload)
    payload['exp'] = 7
  end
end


