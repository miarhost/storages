require 'jwt'
class AuthenticationToken
  
  attr_reader :rsa_public, :rsa_private

  def initialize
    @rsa_private  = OpenSSL::PKey::RSA.generate 2048
    @rsa_public = @rsa_private.public_key
  end

  def self.encode(payload) 
    payload = {user_id: user.id}
    JWT.encode(payload, @rsa_private, 'RS256')
    rescue JWT::InvalidPayload  
  end

  def self.decode(token)
    JWT.decode(token, @rsa_public, true, { algorithm: 'RS256' })
    rescue JWT::DecodeError
  end

  def self.expired(payload)
    payload['exp'] = 7
  end
end


