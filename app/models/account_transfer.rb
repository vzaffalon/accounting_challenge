#encoding: utf-8

class AccountTransfer < ApplicationRecord
    
    belongs_to :source_account, class_name: 'Account'
    belongs_to :destination_account, class_name: 'Account'
  
    after_create :generate_account_transactions

    def generate_account_transactions
        if self.source_account.available_amount >= -amount
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
        else
            return false
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
  