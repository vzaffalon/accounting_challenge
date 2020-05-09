#encoding: utf-8

class User < ApplicationRecord
    
    belongs_to :source_account, class: 'Account'
    belongs_to :destination_account, class: 'Account'

    has_secure_password
    has_secure_password :recovery_password, validations: false
  
end
  