#encoding: utf-8

class AccountTransfer < ApplicationRecord
    
    belongs_to :source_account, class_name: 'Account'
    belongs_to :destination_account, class_name: 'Account'
  
    validate :has_enough_amount

    before_create :generate_account_transactions


    def has_enough_amount
        @source_account = Account.find(self.source_account_id)
        if @source_account.available_amount >= self.amount.abs
            return true
        else
            self.errors.add(:account_transfers, "error")
        end
    end

    def generate_account_transactions
            @debit_transaction = AccountTransaction.create(
                amount: -self.amount,
                account_id: self.source_account.id
            )
            if @debit_transaction
                AccountTransaction.create(
                    amount: self.amount,
                    account_id: self.destination_account.id
                )
            end
    end

    def self.filter_by_params(params)
        scoped = self.where(nil)
    
        if params[:source_account_id]
          scoped = scoped.where('source_account_id = :source_account_id', source_account_id: params[:source_account_id])
        end

        if params[:destination_account_id]
            scoped = scoped.where('destination_account_id = :destination_account_id', destination_account_id: params[:source_accdestination_account_idount_id])
          end
    
        scoped
    end
    
end
  