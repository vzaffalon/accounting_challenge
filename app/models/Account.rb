
class Account < ApplicationRecord
    
    belongs_to :user

    after_create :generate_first_transaction

    def generate_first_transaction
        AccountTransaction.create(
            amount: self.amount,
            account_id: self.id,
        )
    end
  
end