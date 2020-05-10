#encoding: utf-8

class User < ApplicationRecord

    has_many :accounts

    has_secure_password
  
end
  