#encoding: utf-8

class UserToken < ApplicationRecord  
    belongs_to :user
  
    TTL = 30.minutes
  
    before_create do |user_token|
      self.token = generate_authentication_token
    end
  
    private def generate_authentication_token
      loop do
        token = SecureRandom.hex
        break token unless UserToken.exists?(token: token)
      end
    end
end
  