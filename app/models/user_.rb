#encoding: utf-8

class User < ApplicationRecord

    validates :email, :presence => true
    validates_uniqueness_of :email, :scope => [:email]
    has_many :accounts

    has_secure_password
  
end
  