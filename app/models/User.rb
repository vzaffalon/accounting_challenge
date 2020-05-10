#encoding: utf-8

class User < ApplicationRecord

    has_many :accounts

    has_secure_password
    has_secure_password :recovery_password, validations: false
  
end
  