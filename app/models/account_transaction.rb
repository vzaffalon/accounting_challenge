
class AccountTransaction < ApplicationRecord
    
    belongs_to :account
    
    def self.filter_by_params(params)
        scoped = self.where(nil)
    
        if params[:account_id]
          scoped = scoped.where('account_id = :account_id', account_id: params[:account_id])
        end
    
        scoped
    end
end