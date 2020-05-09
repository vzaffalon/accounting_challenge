#encoding: utf-8

class AccountTransfer < ApplicationRecord
    
    belongs_to :source_account, class: 'Account'
    belongs_to :destination_account, class: 'Account'
  
    after_create :generate_account_transactions

    def generate_account_transactions
        @debit_transaction = AccountTransaction.create(
            amount: -amount,
            account_id: self.source_account.id
        )
        if @debit_transaction
            AccountTransaction.create(
                amount: amount,
                account_id: self.destination_account.id
            )
        end
    end
    
end
  