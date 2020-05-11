#encoding: utf-8

class LoginSession < ApplicationRecord  
    belongs_to :user
  
    TTL = 30.minutes
  
    before_create do |login_session|
      self.token = generate_authentication_token
    end
  
    private def generate_authentication_token
      loop do
        token = SecureRandom.hex
        break token unless LoginSession.exists?(token: token)
      end
    end
end
  