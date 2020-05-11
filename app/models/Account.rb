
class Account < ApplicationRecord
    
    belongs_to :user
    has_many :account_transactions
    has_many :account_transfers

    after_create :generate_first_transaction

    def generate_first_transaction
        # AccountTransaction.create(
        #     amount: self.amount,
        #     account_id: self.id,
        # )
    end

    def available_amount
        self.account_transactions.sum(:amount)
    end
  
end