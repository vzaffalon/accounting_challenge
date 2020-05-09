#encoding: utf-8

class AccountTransfer < ApplicationRecord
    
    belongs_to :source_account, class: 'Account'
    belongs_to :destination_account, class: 'Account'
  
  
end
  